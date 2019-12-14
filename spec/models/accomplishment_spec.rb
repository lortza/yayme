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

  describe 'heat_map' do
    it 'returns a hash with words as keys' do
      accomplishment = build(:accomplishment, description: 'a a b b c')
      first_key = 'a'

      expect(accomplishment.word_heat_map.keys.first).to eq(first_key)
    end

    it 'returns a hash with integers as values' do
      accomplishment = build(:accomplishment, description: 'a a b b c')
      first_value = 2

      expect(accomplishment.word_heat_map.values.first).to eq(first_value)
    end

    it 'counts each unique word that appears in a descritption' do
      accomplishment = build(:accomplishment, description: 'a a b b c')
      expected_output = {'a' => 2, 'b' => 2, 'c' => 1}
      
      expect(accomplishment.word_heat_map).to eq(expected_output)
    end
  end
end
