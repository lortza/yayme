# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccomplishmentCategory, type: :model do
  context 'associations' do
    it { should belong_to(:accomplishment) }
    it { should belong_to(:category) }
  end
end
