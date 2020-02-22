# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccomplishmentTypesHelper, type: :helper do
  describe 'template?' do
    it 'displays ✓ if a description template is present' do
      accomplishment_type = build(:accomplishment_type)
      expect(helper.template?(accomplishment_type)).to eq('✓')
    end

    it 'returns nil if no template' do
      accomplishment_type = build(:accomplishment_type, description_template: nil)
      expect(helper.template?(accomplishment_type)).to eq(nil)
    end
  end
end
