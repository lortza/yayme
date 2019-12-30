# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accomplishment, type: :model do
  context 'associations' do
    it { should belong_to(:accomplishment_type) }
  end

  describe 'a valid accomplishment' do
    context 'when has valid params' do
      let(:accomplishment) { build(:accomplishment) }
      it 'is valid' do
        expect(accomplishment).to be_valid
      end

      it { should validate_presence_of(:date) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:accomplishment_type) }
    end
  end

  context 'delegations' do
    it { should delegate_method(:name).to(:accomplishment_type).with_prefix }
  end

  describe 'self.for_year' do
    it 'returns all records if no year is given' do
      accomplishment1 = create(:accomplishment, date: '2018-01-16')
      accomplishment2 = create(:accomplishment, date: '2019-01-16')
      given_year = ''

      expect(Accomplishment.for_year(given_year)).to include(accomplishment1, accomplishment2)
    end

    it 'returns only accomplishments for a given year' do
      accomplishment1 = create(:accomplishment, date: '2018-01-16')
      accomplishment2 = create(:accomplishment, date: '2019-01-16')
      given_year = '2018'

      expect(Accomplishment.for_year(given_year)).to include(accomplishment1)
      expect(Accomplishment.for_year(given_year)).to_not include(accomplishment2)
    end
  end

  describe 'self.search' do
    xit 'does stuff' do
    end
  end

  describe 'self.for_words' do
    it 'returns all records if no search_term is given' do
      accomplishment1 = create(:accomplishment, description: 'flower')
      accomplishment2 = create(:accomplishment, description: 'moonwalk')
      search_term = ''

      expect(Accomplishment.for_words(search_term)).to include(accomplishment1, accomplishment2)
    end

    it 'returns only relevant records if a search term is present in the description' do
      accomplishment1 = create(:accomplishment, description: 'flower')
      accomplishment2 = create(:accomplishment, description: 'moonwalk')
      search_term = 'flower'

      expect(Accomplishment.for_words(search_term)).to include(accomplishment1)
      expect(Accomplishment.for_words(search_term)).to_not include(accomplishment2)
    end

    it 'returns only relevant records if a search term is present in the given_by field' do
      accomplishment1 = create(:accomplishment, given_by: 'Starsky')
      accomplishment2 = create(:accomplishment, given_by: 'Hutch')
      search_term = 'Starsky'

      expect(Accomplishment.for_words(search_term)).to include(accomplishment1)
      expect(Accomplishment.for_words(search_term)).to_not include(accomplishment2)
    end
  end

  describe 'word_cloud' do
    it 'returns a hash with words as keys' do
      accomplishment = build(:accomplishment, description: 'a a b b c')
      first_key = 'a'

      expect(accomplishment.word_cloud.keys.first).to eq(first_key)
    end

    it 'returns a hash with integers as values' do
      accomplishment = build(:accomplishment, description: 'a a b b c')
      first_value = 2

      expect(accomplishment.word_cloud.values.first).to eq(first_value)
    end

    it 'counts each unique word that appears in a descritption' do
      accomplishment = build(:accomplishment, description: 'a a b b c')
      expected_output = { 'a' => 2, 'b' => 2, 'c' => 1 }

      expect(accomplishment.word_cloud).to eq(expected_output)
    end

    it 'is case-insensitive' do
      accomplishment = build(:accomplishment, description: 'A a B b c')
      expected_output = { 'a' => 2, 'b' => 2, 'c' => 1 }

      expect(accomplishment.word_cloud).to eq(expected_output)
    end

    it 'removes unnecessary punctuation' do
      accomplishment = build(:accomplishment, description: 'a, a (b) b. c c, d')
      expected_output = { 'a' => 2, 'b' => 2, 'c' => 2, 'd' => 1 }

      expect(accomplishment.word_cloud).to eq(expected_output)
    end
  end
end
