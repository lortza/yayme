# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:accomplishment_categories) }
    it { should have_many(:accomplishments).through(:accomplishment_categories) }
  end
end
