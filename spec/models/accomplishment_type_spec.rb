# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccomplishmentType, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:posts) }
  end

  describe 'a valid accomplishment_type' do
    context 'when has valid params' do
      it 'is valid' do
        expect(accomplishment_type).to be_valid
      end

      it { should validate_presence_of(:name) }
      it { should_not validate_presence_of(:description_template) }

      let!(:accomplishment_type) { create(:accomplishment_type) }
      it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    end
  end
end
