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
end
