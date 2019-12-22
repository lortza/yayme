# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccomplishmentsHelper, type: :helper do
  let(:last_item) { 'All Time' }

  describe 'years_dropdown' do
    it 'lists all available years' do
      allow(Report).to receive(:available_years).and_return([2019])
      expect(helper.years_dropdown).to eq([2019, last_item])
    end

    it 'has "All Time" as the last option' do
      allow(Report).to receive(:available_years).and_return([2019])
      expect(helper.years_dropdown.last).to eq(last_item)
    end
  end
end
