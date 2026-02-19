# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  context "associations" do
    it { should belong_to(:post_type) }
  end

  describe "a valid post" do
    context "when has valid params" do
      let(:post) { build(:post) }
      it "is valid" do
        expect(post).to be_valid
      end

      it { should validate_presence_of(:date) }
      it { should validate_presence_of(:description) }
    end
  end

  context "delegations" do
    it { should delegate_method(:name).to(:post_type).with_prefix }
  end

  describe "scopes" do
    describe "bookmarked" do
      let!(:bookmarked_post) { create(:post, bookmarked: true) }
      let!(:unbookmarked_post) { create(:post, bookmarked: false) }

      it "returns bookmarked posts" do
        results = Post.bookmarked
        expect(results).to include(bookmarked_post)
      end

      it "excludes non-bookmarked posts" do
        results = Post.bookmarked
        expect(results).to_not include(unbookmarked_post)
      end
    end

    describe "by_date" do
      it "returns posts in descending date order" do
        post1 = create(:post, date: "2018-01-01")
        post2 = create(:post, date: "2018-01-02")
        results = Post.by_date

        expect(results.first).to eq(post2)
        expect(results.second).to eq(post1)
      end
    end

    describe "in_chronological_order" do
      it "returns posts in ascending date order" do
        post1 = create(:post, date: "2018-01-02")
        post2 = create(:post, date: "2018-01-01")
        results = Post.in_chronological_order

        expect(results.first).to eq(post2)
        expect(results.second).to eq(post1)
      end
    end

    describe "in_post_type_ids" do
      let(:type1) { create(:post_type) }
      let(:type2) { create(:post_type) }
      let(:type3) { create(:post_type, name: "unused") }
      let!(:post1) { create(:post, post_type: type1) }
      let!(:post2) { create(:post, post_type: type2) }
      let!(:post3) { create(:post, post_type: type1) }

      describe "when 1 post_type is provided" do
        it "returns posts for that only post_type" do
          results = Post.in_post_type_ids([type1.id])
          aggregate_failures "included posts" do
            expect(results).to include(post1)
            expect(results).to_not include(post2)
            expect(results).to include(post3)
          end
        end
      end

      describe "when 1+ post_types are provided" do
        it "returns posts for both post types" do
          results = Post.in_post_type_ids([type1.id, type2.id])
          aggregate_failures "included posts" do
            expect(results).to include(post1)
            expect(results).to include(post2)
          end
        end
      end

      describe "when no posts match the provided post_types" do
        it "returns []" do
          results = Post.in_post_type_ids([type3.id])
          expect(results).to eq([])
        end
      end
    end

    describe "in_category_ids" do
      let(:category1) { create(:category) }
      let(:category2) { create(:category) }
      let(:category3) { create(:category, name: "unused") }
      let!(:post1) { create(:post) }
      let!(:post2) { create(:post) }
      let!(:post3) { create(:post) }

      describe "when 1 category_id is provided" do
        it "returns posts for that only category_id" do
          post1.categories << category1
          post2.categories << category2
          post3.categories << category1

          results = Post.in_category_ids([category1.id])
          aggregate_failures "included posts" do
            expect(results).to include(post1)
            expect(results).to_not include(post2)
            expect(results).to include(post3)
          end
        end
      end

      describe "when 1+ category_ids are provided" do
        it "returns posts for both post types" do
          post1.categories << category1
          post2.categories << category2
          post3.categories << category3

          results = Post.in_category_ids([category1.id, category2.id])
          aggregate_failures "included posts" do
            expect(results).to include(post1)
            expect(results).to include(post2)
            expect(results).to_not include(post3)
          end
        end
      end

      describe "when no posts match the provided category_ids" do
        it "returns []" do
          post1.categories << category1
          post2.categories << category2

          results = Post.in_category_ids([category3.id])
          expect(results).to eq([])
        end
      end
    end
  end

  describe "self.for_year" do
    it "returns all records if no year is given" do
      post1 = create(:post, date: "2018-01-16")
      post2 = create(:post, date: "2019-01-16")
      given_year = ""

      expect(Post.for_year(given_year)).to include(post1, post2)
    end

    it "returns only posts for a given year" do
      post1 = create(:post, date: "2018-01-16")
      post2 = create(:post, date: "2019-01-16")
      given_year = "2018"

      expect(Post.for_year(given_year)).to include(post1)
      expect(Post.for_year(given_year)).to_not include(post2)
    end
  end

  describe "self.for_timeframe" do
    let!(:post_today) { create(:post, date: Time.zone.today) }
    let!(:post_past_week) { create(:post, date: (Time.zone.today - 3)) }
    let!(:post_past_month) { create(:post, date: (Time.zone.today - 15)) }
    let!(:post_past_quarter) { create(:post, date: (Time.zone.today - 80)) }

    it "only returns posts for the given timeframe" do
      posts = Post.for_timeframe("Past Month")

      expect(posts).to include(post_today)
      expect(posts).to include(post_past_week)
      expect(posts).to include(post_past_month)
      expect(posts).to_not include(post_past_quarter)
    end

    it 'returns all posts when the given_year is "All Time"' do
      posts = Post.for_timeframe("All Time")
      expect(posts.count).to eq(4)
    end

    it "returns all posts when the given_year is invalid" do
      posts = Post.for_timeframe("something invalid")
      expect(posts.count).to eq(4)
    end
  end

  describe "self.search" do
    let(:today) { Time.zone.today }
    let(:bookmarked_post) { create(:post, date: today, bookmarked: true) }
    let(:unbookmarked_post) { create(:post, date: today, bookmarked: false) }

    describe "bookmarks" do
      it "returns both bookmarked and unbookmarked posts if no value is given" do
        bookmarked_post
        unbookmarked_post
        results = Post.search

        expect(results.to_a).to include(bookmarked_post)
        expect(results.to_a).to include(unbookmarked_post)
      end

      it "returns only bookmarked posts if a true value is supplied" do
        bookmarked_post
        unbookmarked_post
        results = Post.search(bookmarked: true)

        expect(results.to_a).to include(bookmarked_post)
        expect(results.to_a).to_not include(unbookmarked_post)
      end
    end

    describe "timeframe & text" do
      it "returns all posts for current year if no terms are given" do
        last_year_post = create(:post, date: "2019-01-16")
        this_year_post = create(:post, date: "2020-01-16")

        allow(Report).to receive(:this_year).and_return("2020")
        results = Post.search

        expect(results).to_not include(last_year_post)
        expect(results).to include(this_year_post)
      end

      it "if a year is given, it returns posts only from the given year" do
        last_year_post = create(:post, date: "2019-01-16")
        this_year_post = create(:post, date: "2020-01-16")
        given_year = "2019"

        results = Post.search(year: given_year)

        expect(results).to include(last_year_post)
        expect(results).to_not include(this_year_post)
      end

      it "returns only post with both the given year and given term if present" do
        given_year = "2019"
        search_terms = "kittens"

        right_year_right_term = create(:post, date: "2019-01-01", description: search_terms)
        right_year_wrong_term = create(:post, date: "2019-01-02", description: "puppies")
        wrong_year_right_term = create(:post, date: "2020-01-16", description: search_terms)

        results = Post.search(year: given_year, text: search_terms)

        expect(results).to include(right_year_right_term)
        expect(results).to_not include(right_year_wrong_term)
        expect(results).to_not include(wrong_year_right_term)
      end

      it 'returns all posts when given_year is "All Time"' do
        given_year = "All Time"

        post1 = create(:post, date: "2018-01-01")
        post2 = create(:post, date: "2019-01-01")
        post3 = create(:post, date: "2020-01-01")

        results = Post.search(year: given_year)

        aggregate_failures "included posts" do
          expect(results).to include(post1)
          expect(results).to include(post2)
          expect(results).to include(post3)
        end
      end
    end
  end

  describe "self.filter_for_export" do
    let(:type) { create(:post_type) }

    it "returns [] if there are no user posts" do
      expect(Post.filter_for_export).to eq([])
    end

    describe "filtering post_type_ids" do
      let!(:post) { create(:post, post_type: type) }

      describe "when post_type_ids are provided" do
        it "queries for post_type" do
          expect(Post).to receive(:in_post_type_ids).with(["1"])
          Post.filter_for_export(post_type_ids: ["1"])
        end
      end

      describe "when post_type_ids are not provided" do
        it "does not query for by post_type" do
          expect(Post).to_not receive(:in_post_type_ids)
          Post.filter_for_export(post_type_ids: [])
        end
      end
    end

    describe "filtering text" do
      let!(:post) { create(:post, description: "hello") }

      describe "when text is provided" do
        it "queries for description" do
          expect(Post).to receive(:for_words).with("hello")
          Post.filter_for_export(text: "hello")
        end
      end

      describe "when text is not provided" do
        it "does not query for description" do
          expect(Post).to_not receive(:for_words).with("hello")
          Post.filter_for_export(text: "")
        end
      end
    end

    describe "filtering with_people" do
      let!(:post1) { create(:post, given_by: "George") }

      describe "when text is provided" do
        it "queries for given_by" do
          expect(Post).to receive(:for_words).with("George")
          Post.filter_for_export(with_people: "George")
        end
      end

      describe "when text is not provided" do
        it "does not query for given_by" do
          expect(Post).to_not receive(:for_words)
          Post.filter_for_export(with_people: "")
        end
      end
    end

    describe "filtering bookmarked" do
      let!(:post) { create(:post, bookmarked: false) }

      describe "when bookmarked is true" do
        it "queries for bookmarked" do
          expect(Post).to receive(:bookmarked)
          Post.filter_for_export(bookmarked: true)
        end
      end

      describe "when bookmarked is false" do
        it "queries for bookmarked" do
          expect(Post).to receive(:bookmarked)
          Post.filter_for_export(bookmarked: false)
        end
      end

      describe "when bookmarked is nil" do
        it "does not query for bookmarked" do
          expect(Post).to_not receive(:bookmarked)
          Post.filter_for_export(bookmarked: nil)
        end
      end
    end

    describe "filtering in_category_ids" do
      let!(:post) { create(:post) }

      describe "when category_ids is provided" do
        it "queries for category_id" do
          expect(Post).to receive(:in_category_ids).with(["1"])
          Post.filter_for_export(category_ids: ["1"])
        end
      end

      describe "when category_ids is not provided" do
        it "does not query for category_id" do
          expect(Post).to_not receive(:in_category_ids)
          Post.filter_for_export(category_ids: [])
        end
      end
    end
  end

  describe "self.for_words" do
    it "returns all records if no search_term is given" do
      post1 = create(:post, description: "flower")
      post2 = create(:post, description: "moonwalk")
      search_term = ""

      expect(Post.for_words(search_term)).to include(post1, post2)
    end

    it "returns only relevant records if a search term is present in the description" do
      post1 = create(:post, description: "flower")
      post2 = create(:post, description: "moonwalk")
      search_term = "flower"

      expect(Post.for_words(search_term)).to include(post1)
      expect(Post.for_words(search_term)).to_not include(post2)
    end

    it "returns only relevant records if a search term is present in the with_people field" do
      post1 = create(:post, with_people: "Starsky")
      post2 = create(:post, with_people: "Hutch")
      search_term = "Starsky"

      expect(Post.for_words(search_term)).to include(post1)
      expect(Post.for_words(search_term)).to_not include(post2)
    end
  end

  describe "word_cloud" do
    it "returns a hash with words as keys" do
      post = build(:post, description: "a a b b c")
      first_key = "a"

      expect(post.word_cloud.keys.first).to eq(first_key)
    end

    it "returns a hash with integers as values" do
      post = build(:post, description: "a a b b c")
      first_value = 2

      expect(post.word_cloud.values.first).to eq(first_value)
    end

    it "counts each unique word that appears in a descritption" do
      post = build(:post, description: "a a b b c")
      expected_output = {"a" => 2, "b" => 2, "c" => 1}

      expect(post.word_cloud).to eq(expected_output)
    end

    it "is case-insensitive" do
      post = build(:post, description: "A a B b c")
      expected_output = {"a" => 2, "b" => 2, "c" => 1}

      expect(post.word_cloud).to eq(expected_output)
    end

    it "removes unnecessary punctuation" do
      post = build(:post, description: "a, a (b) b. c c, d")
      expected_output = {"a" => 2, "b" => 2, "c" => 2, "d" => 1}

      expect(post.word_cloud).to eq(expected_output)
    end

    it "removes code blocks enclosed in triple backticks" do
      post = build(:post, description: "I wrote ```ruby\ndef hello\n  puts 'world'\nend\n``` today")
      expected_output = {"i" => 1, "wrote" => 1, "today" => 1}

      expect(post.word_cloud).to eq(expected_output)
    end

    it "handles multiple code blocks" do
      post = build(:post, description: "First ```code block``` and second ```another block``` test")
      expected_output = {"first" => 1, "and" => 1, "second" => 1, "test" => 1}

      expect(post.word_cloud).to eq(expected_output)
    end

    it "skips empty words after stripping punctuation" do
      post = build(:post, description: "test... ...test")
      expected_output = {"test" => 2}

      expect(post.word_cloud).to eq(expected_output)
    end
  end

  describe "#acceptable_image" do
    context "when no image is attached" do
      it "is valid" do
        post = build(:post)
        expect(post).to be_valid
      end
    end

    context "when a JPEG is attached" do
      it "is valid" do
        post = build(:post)
        without_partial_double_verification do
          allow(post.image).to receive(:attached?).and_return(true)
          allow(post.image).to receive(:content_type).and_return("image/jpeg")
        end
        expect(post).to be_valid
      end
    end

    context "when a PNG is attached" do
      it "is valid" do
        post = build(:post)
        without_partial_double_verification do
          allow(post.image).to receive(:attached?).and_return(true)
          allow(post.image).to receive(:content_type).and_return("image/png")
        end
        expect(post).to be_valid
      end
    end

    context "when a non-image file is attached" do
      it "is invalid" do
        post = build(:post)
        without_partial_double_verification do
          allow(post.image).to receive(:attached?).and_return(true)
          allow(post.image).to receive(:content_type).and_return("application/pdf")
        end
        expect(post).not_to be_valid
        expect(post.errors[:image]).to include("must be a JPEG or PNG")
      end
    end

    context "when an image of any size is attached" do
      it "is valid regardless of file size" do
        post = build(:post)
        without_partial_double_verification do
          allow(post.image).to receive(:attached?).and_return(true)
          allow(post.image).to receive(:content_type).and_return("image/jpeg")
        end
        expect(post).to be_valid
      end
    end
  end

  describe "#process_image" do
    let(:post) { create(:post) }
    let(:tempfile) { Tempfile.new("input") }
    let(:result) { Tempfile.new("result") }
    let(:blob) { instance_double(ActiveStorage::Blob, filename: ActiveStorage::Filename.new("photo.jpg"), content_type: "image/jpeg") }
    let(:new_blob) { instance_double(ActiveStorage::Blob) }

    before do
      without_partial_double_verification do
        allow(post.image).to receive(:blob).and_return(blob)
        allow(post.image).to receive(:attach)
      end
      allow(result).to receive(:rewind)
      allow(result).to receive(:close!)
      allow(ActiveStorage::Blob).to receive(:create_and_upload!).and_return(new_blob)
    end

    context "when the blob has already been processed" do
      before { allow(blob).to receive(:metadata).and_return({ "processed" => true }) }

      it "skips processing" do
        expect(post).not_to receive(:compress_image_to_500kb)
        post.send(:process_image)
      end
    end

    context "when the blob has not been processed" do
      before do
        allow(blob).to receive(:metadata).and_return({})
        allow(blob).to receive(:open).and_yield(tempfile)
        allow(post).to receive(:compress_image_to_500kb).and_return(result)
      end

      it "compresses the image" do
        expect(post).to receive(:compress_image_to_500kb).with(tempfile).and_return(result)
        post.send(:process_image)
      end

      it "creates a new blob marked as processed" do
        expect(ActiveStorage::Blob).to receive(:create_and_upload!).with(
          hash_including(metadata: { "processed" => true })
        )
        post.send(:process_image)
      end

      it "attaches the new blob to the image" do
        without_partial_double_verification do
          expect(post.image).to receive(:attach).with(new_blob)
        end
        post.send(:process_image)
      end

      it "cleans up the result tempfile" do
        expect(result).to receive(:close!)
        post.send(:process_image)
      end
    end

    context "when processing raises an error" do
      before do
        allow(blob).to receive(:metadata).and_return({})
        allow(blob).to receive(:open).and_raise(StandardError, "disk error")
      end

      it "logs the error" do
        expect(Rails.logger).to receive(:error).with(/Image processing failed for Post #{post.id}/)
        post.send(:process_image)
      end

      it "does not raise" do
        expect { post.send(:process_image) }.not_to raise_error
      end
    end
  end

  describe "#compress_image_to_500kb" do
    let(:post) { build(:post) }
    let(:input) { Tempfile.new("input") }
    let(:pipeline) { double("pipeline", resize_to_limit: nil, saver: nil, call: nil) }

    before do
      allow(pipeline).to receive(:resize_to_limit).and_return(pipeline)
      allow(pipeline).to receive(:saver).and_return(pipeline)
      allow(ImageProcessing::MiniMagick).to receive(:source).and_return(pipeline)
    end

    context "when the first pass produces an image <= 500kb" do
      let(:small_result) { Tempfile.new("small") }

      before { allow(small_result).to receive(:size).and_return(300.kilobytes) }

      it "returns after the first pass" do
        allow(pipeline).to receive(:call).and_return(small_result)
        result = post.send(:compress_image_to_500kb, input)
        expect(result).to eq(small_result)
      end

      it "does not attempt further compression" do
        allow(pipeline).to receive(:call).and_return(small_result)
        expect(pipeline).to receive(:call).once
        post.send(:compress_image_to_500kb, input)
      end
    end

    context "when the first pass still exceeds 500kb" do
      let(:large_result) { Tempfile.new("large") }
      let(:medium_result) { Tempfile.new("medium") }

      before do
        allow(large_result).to receive(:size).and_return(600.kilobytes)
        allow(large_result).to receive(:close!)
        allow(medium_result).to receive(:size).and_return(400.kilobytes)
        allow(pipeline).to receive(:call).and_return(large_result, medium_result)
      end

      it "returns after the second pass" do
        result = post.send(:compress_image_to_500kb, input)
        expect(result).to eq(medium_result)
      end

      it "cleans up the first pass result" do
        expect(large_result).to receive(:close!)
        post.send(:compress_image_to_500kb, input)
      end
    end

    context "when both first and second passes exceed 500kb" do
      let(:large_result1) { Tempfile.new("large1") }
      let(:large_result2) { Tempfile.new("large2") }
      let(:final_result) { Tempfile.new("final") }

      before do
        allow(large_result1).to receive(:size).and_return(700.kilobytes)
        allow(large_result1).to receive(:close!)
        allow(large_result2).to receive(:size).and_return(600.kilobytes)
        allow(large_result2).to receive(:close!)
        allow(pipeline).to receive(:call).and_return(large_result1, large_result2, final_result)
      end

      it "returns the third pass result" do
        result = post.send(:compress_image_to_500kb, input)
        expect(result).to eq(final_result)
      end

      it "cleans up both intermediate results" do
        expect(large_result1).to receive(:close!)
        expect(large_result2).to receive(:close!)
        post.send(:compress_image_to_500kb, input)
      end
    end
  end

  describe "#remove_code_blocks" do
    let(:post) { build(:post) }

    it "removes content between triple backticks" do
      text = "Hello ```code here``` world"
      result = post.send(:remove_code_blocks, text)

      expect(result).to eq("Hello   world")
    end

    it "removes multiline code blocks" do
      text = "Start\n```\nline1\nline2\nline3\n```\nEnd"
      result = post.send(:remove_code_blocks, text)

      expect(result).to eq("Start\n \nEnd")
    end

    it "removes multiple code blocks" do
      text = "First ```block1``` middle ```block2``` end"
      result = post.send(:remove_code_blocks, text)

      expect(result).to eq("First   middle   end")
    end

    it "returns original text if no code blocks present" do
      text = "No code blocks here"
      result = post.send(:remove_code_blocks, text)

      expect(result).to eq(text)
    end
  end
end
