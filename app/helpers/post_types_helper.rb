# frozen_string_literal: true

module PostTypesHelper
  def template?(post_type)
    "✓" if post_type.description_template.present?
  end
end
