# frozen_string_literal: true

require "rails_helper"

RSpec.describe Report, type: :model do
  describe "self.generate_word_cloud" do
    let(:user) { create(:user) }
    let(:post_type) { create(:post_type, user: user) }

    it "counts each unique word that appears in a description" do
      create(:post, post_type: post_type, date: Date.current, description: "apple ball cat")
      create(:post, post_type: post_type, date: Date.current, description: "apple ball dog")
      create(:post, post_type: post_type, date: Date.current, description: "apple ball elephant")
      expected_output = {"apple" => 3, "ball" => 3, "cat" => 1, "dog" => 1, "elephant" => 1}

      result = Report.generate_word_cloud(
        user: user,
        search_params: {year: Report.this_year},
        minimum_count: 0
      )

      expect(result).to eq(expected_output)
    end

    it "filters out template words from user's post_types" do
      post_type_with_template = create(:post_type, user: user, description_template: "Today was amazing and wonderful")
      create(:post, post_type: post_type_with_template, date: Date.current, description: "Today was amazing I learned something new")
      create(:post, post_type: post_type_with_template, date: Date.current, description: "Wonderful day with great friends")

      result = Report.generate_word_cloud(
        user: user,
        search_params: {year: Report.this_year},
        minimum_count: 0
      )

      # "today", "was", "amazing", "wonderful", "and", "with" should be filtered (template or stop words)
      # Should only include unique user-added words
      expect(result.keys).to include("learned", "something", "new", "day", "great", "friends")
      expect(result.keys).not_to include("amazing", "wonderful", "with")
    end
  end

  describe "self.available_years" do
    it "returns an array of years taken from Accomlishment records" do
      create(:post, date: "2018-01-16")
      create(:post, date: "2019-01-16")

      expect(Report.available_years).to eq([2019, 2018])
    end

    it "orders years in descending order" do
      create(:post, date: "2018-01-16")
      create(:post, date: "2017-01-16")
      create(:post, date: "2019-01-16")

      expect(Report.available_years).to eq([2019, 2018, 2017])
    end

    it 'defaults to the "Post" model' do
      create(:post, date: "2018-01-16")
      create(:post, date: "2019-01-16")

      expect(Report.available_years).to eq([2019, 2018])
    end

    it "can work for any model and date field" do
      create(:post_type, created_at: "2018-01-16")

      expect(Report.available_years(PostType, :created_at)).to eq([2018])
    end
  end

  describe "self.filter_out_code_artifacts" do
    it "filters out HTML tags" do
      words_hash = {"hello" => 5, "<div>" => 3, "world" => 4, "</span>" => 2}
      result = Report.send(:filter_out_code_artifacts, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end

    it "filters out special character-only strings" do
      words_hash = {"hello" => 5, "{" => 3, "}" => 2, "[" => 1, "world" => 4}
      result = Report.send(:filter_out_code_artifacts, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end

    it "filters out words containing ampersands (HTML entities)" do
      words_hash = {"hello" => 5, "&nbsp;" => 3, "world" => 4, "&amp;" => 2}
      result = Report.send(:filter_out_code_artifacts, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end

    it "filters out common code keywords" do
      words_hash = {"hello" => 5, "div" => 3, "function" => 2, "const" => 1, "world" => 4}
      result = Report.send(:filter_out_code_artifacts, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end

    it "keeps normal words intact" do
      words_hash = {"hello" => 5, "world" => 4, "testing" => 3}
      result = Report.send(:filter_out_code_artifacts, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4, "testing" => 3})
    end

    it "filters multiple types of code artifacts at once" do
      words_hash = {
        "hello" => 5,
        "<div>" => 3,
        "{" => 2,
        "function" => 1,
        "&nbsp;" => 1,
        "world" => 4
      }
      result = Report.send(:filter_out_code_artifacts, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end
  end

  describe "self.filter_out_common" do
    it "filters out short words (1-2 characters)" do
      words_hash = {"hello" => 5, "a" => 10, "hi" => 3, "world" => 4}
      result = Report.send(:filter_out_common, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end

    it "filters out numeric-only strings" do
      words_hash = {"hello" => 5, "123" => 3, "2024" => 2, "world" => 4}
      result = Report.send(:filter_out_common, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end

    it "filters out common stop words" do
      words_hash = {"hello" => 5, "the" => 10, "and" => 8, "world" => 4}
      result = Report.send(:filter_out_common, words_hash)

      expect(result).to eq({"hello" => 5, "world" => 4})
    end

    it "keeps meaningful words" do
      words_hash = {"amazing" => 5, "wonderful" => 4, "fantastic" => 3}
      result = Report.send(:filter_out_common, words_hash)

      expect(result).to eq({"amazing" => 5, "wonderful" => 4, "fantastic" => 3})
    end
  end

  describe "self.extract_words_from_text" do
    it "extracts words from text" do
      text = "Hello world, this is a test!"
      result = Report.send(:extract_words_from_text, text)

      expect(result).to include("hello", "world", "this", "test")
    end

    it "removes code blocks before extracting words" do
      text = "Hello ```code here``` world"
      result = Report.send(:extract_words_from_text, text)

      expect(result).to eq(["hello", "world"])
    end

    it "filters out words with 2 or fewer characters" do
      text = "I am ok but we are going"
      result = Report.send(:extract_words_from_text, text)

      expect(result).not_to include("i", "am", "ok", "we")
      expect(result).to include("but", "are", "going")
    end

    it "removes punctuation and lowercases words" do
      text = "Hello! World? Test..."
      result = Report.send(:extract_words_from_text, text)

      expect(result).to eq(["hello", "world", "test"])
    end
  end

  describe "self.extract_all_template_words" do
    let(:user) { create(:user) }

    it "extracts words from all user's post_type templates" do
      create(:post_type, user: user, description_template: "Today was amazing")
      create(:post_type, user: user, description_template: "I feel grateful for")

      result = Report.send(:extract_all_template_words, user)

      expect(result).to include("today", "amazing", "feel", "grateful", "for")
    end

    it "ignores post_types with nil templates" do
      create(:post_type, user: user, description_template: nil)
      create(:post_type, user: user, description_template: "Hello world")

      result = Report.send(:extract_all_template_words, user)

      expect(result).to eq(["hello", "world"])
    end

    it "ignores post_types with empty templates" do
      create(:post_type, user: user, description_template: "")
      create(:post_type, user: user, description_template: "Hello world")

      result = Report.send(:extract_all_template_words, user)

      expect(result).to eq(["hello", "world"])
    end

    it "returns unique words only" do
      create(:post_type, user: user, description_template: "Hello world")
      create(:post_type, user: user, description_template: "Hello universe")

      result = Report.send(:extract_all_template_words, user)

      expect(result.count("hello")).to eq(1)
    end
  end
end
