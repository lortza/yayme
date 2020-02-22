# frozen_string_literal: true

module AccomplishmentTypesHelper
  def template?(accomplishment_type)
    return '✓' if accomplishment_type.description_template.present?
  end
end
