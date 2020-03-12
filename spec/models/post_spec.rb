# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations' do
    it { should belong_to(:post_type) }
  end

  describe 'a valid post' do
    context 'when has valid params' do
      let(:post) { build(:post) }
      it 'is valid' do
        expect(post).to be_valid
      end

      it { should validate_presence_of(:date) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:post_type) }
    end
  end

  context 'delegations' do
    it { should delegate_method(:name).to(:post_type).with_prefix }
  end

  describe 'self.for_year' do
    it 'returns all records if no year is given' do
      post1 = create(:post, date: '2018-01-16')
      post2 = create(:post, date: '2019-01-16')
      given_year = ''

      expect(Post.for_year(given_year)).to include(post1, post2)
    end

    it 'returns only posts for a given year' do
      post1 = create(:post, date: '2018-01-16')
      post2 = create(:post, date: '2019-01-16')
      given_year = '2018'

      expect(Post.for_year(given_year)).to include(post1)
      expect(Post.for_year(given_year)).to_not include(post2)
    end
  end

  describe 'self.search' do
    xit 'does stuff' do
    end
  end

  describe 'self.for_words' do
    it 'returns all records if no search_term is given' do
      post1 = create(:post, description: 'flower')
      post2 = create(:post, description: 'moonwalk')
      search_term = ''

      expect(Post.for_words(search_term)).to include(post1, post2)
    end

    it 'returns only relevant records if a search term is present in the description' do
      post1 = create(:post, description: 'flower')
      post2 = create(:post, description: 'moonwalk')
      search_term = 'flower'

      expect(Post.for_words(search_term)).to include(post1)
      expect(Post.for_words(search_term)).to_not include(post2)
    end

    it 'returns only relevant records if a search term is present in the given_by field' do
      post1 = create(:post, given_by: 'Starsky')
      post2 = create(:post, given_by: 'Hutch')
      search_term = 'Starsky'

      expect(Post.for_words(search_term)).to include(post1)
      expect(Post.for_words(search_term)).to_not include(post2)
    end
  end

  describe 'word_cloud' do
    it 'returns a hash with words as keys' do
      post = build(:post, description: 'a a b b c')
      first_key = 'a'

      expect(post.word_cloud.keys.first).to eq(first_key)
    end

    it 'returns a hash with integers as values' do
      post = build(:post, description: 'a a b b c')
      first_value = 2

      expect(post.word_cloud.values.first).to eq(first_value)
    end

    it 'counts each unique word that appears in a descritption' do
      post = build(:post, description: 'a a b b c')
      expected_output = { 'a' => 2, 'b' => 2, 'c' => 1 }

      expect(post.word_cloud).to eq(expected_output)
    end

    it 'is case-insensitive' do
      post = build(:post, description: 'A a B b c')
      expected_output = { 'a' => 2, 'b' => 2, 'c' => 1 }

      expect(post.word_cloud).to eq(expected_output)
    end

    it 'removes unnecessary punctuation' do
      post = build(:post, description: 'a, a (b) b. c c, d')
      expected_output = { 'a' => 2, 'b' => 2, 'c' => 2, 'd' => 1 }

      expect(post.word_cloud).to eq(expected_output)
    end
  end

  describe 'self.format_image_url' do
    # NOTE: method runs before_save

    it 'safely handles nils' do
      post = build(:post, image_url: nil)
      post.save

      expect(post.image_url).to eq('')
    end

    it 'formats the url' do
      post = build(:post, image_url: 'some_url')
      allow(DropboxApi).to receive(:format_url).and_return('fixed_url')
      post.save

      expect(post.image_url).to eq('fixed_url')
    end
  end
end
