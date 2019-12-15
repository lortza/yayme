# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do

  describe 'self.generate_word_heat_map' do
    it 'returns an array of arrays with [word, count]' do
      create(:accomplishment, description: 'a b c')
      create(:accomplishment, description: 'a b d')
      create(:accomplishment, description: 'a b e')

      expect(Report.generate_word_heat_map(Accomplishment.all).class).to eq(Array)
      expect(Report.generate_word_heat_map(Accomplishment.all).first.class).to eq(Array)
      expect(Report.generate_word_heat_map(Accomplishment.all).first[0]).to eq('a')
      expect(Report.generate_word_heat_map(Accomplishment.all).first[1]).to eq(3)
    end

    it 'counts each unique word that appears in a description' do
      create(:accomplishment, description: 'a b c')
      create(:accomplishment, description: 'a b d')
      create(:accomplishment, description: 'a b e')
      expected_output = [['a', 3], ['b', 3], ['c', 1], ['d', 1], ['e', 1]]

      expect(Report.generate_word_heat_map(Accomplishment.all)).to eq(expected_output)
    end
  end
end
