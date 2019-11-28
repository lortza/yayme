# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'associations' do
    it { should have_many(:accomplishment_types) }
    it { should have_many(:accomplishments).through(:accomplishment_types) }
  end
end
