# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
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

  describe 'display_categories' do
    let!(:category1) { create(:category, name: 'lorem') }
    let!(:category2) { create(:category, name: 'ipsum') }
    let!(:post) { create(:post) }

    it 'displays a list of categories for the post' do
      post.categories << [category1, category2]
      expect(helper.display_categories(post)).to eq('lorem, ipsum')
    end

    it 'returns an empty string if no categories are available' do
      expect(helper.display_categories(post)).to eq('')
    end
  end
end
