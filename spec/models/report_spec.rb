# frozen_string_literal: true

require "rails_helper"

RSpec.describe Report, type: :model do
  describe "self.generate_word_cloud" do
    it "counts each unique word that appears in a description" do
      create(:post, description: "apple ball cat")
      create(:post, description: "apple ball dog")
      create(:post, description: "apple ball elephant")
      expected_output = {"apple" => 3, "ball" => 3, "cat" => 1, "dog" => 1, "elephant" => 1}

      expect(Report.generate_word_cloud(posts: Post.all, minimum_count: 0)).to eq(expected_output)
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
end
