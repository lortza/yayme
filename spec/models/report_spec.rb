# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do

  describe 'self.generate_word_heat_map' do
    it 'counts each unique word that appears in a description' do
      create(:accomplishment, description: 'apple ball cat')
      create(:accomplishment, description: 'apple ball dog')
      create(:accomplishment, description: 'apple ball elephant')
      expected_output = { 'apple'=>3, 'ball'=>3, 'cat'=>1, 'dog'=>1, 'elephant'=>1 }

      expect(Report.generate_word_heat_map(accomplishments: Accomplishment.all, minimum_count: 0)).to eq(expected_output)
    end
  end

  describe 'self.available_years' do
    it 'returns an array of years taken from Accomlishment records' do
      create(:accomplishment, date: '2018-01-16')
      create(:accomplishment, date: '2019-01-16')

      expect(Report.available_years).to eq([2019, 2018])
    end

    it 'orders years in descending order' do
      create(:accomplishment, date: '2018-01-16')
      create(:accomplishment, date: '2017-01-16')
      create(:accomplishment, date: '2019-01-16')

      expect(Report.available_years).to eq([2019, 2018, 2017])
    end

  end
end
