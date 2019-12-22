# frozen_string_literal: true

module AccomplishmentsHelper
  def years_dropdown
    Report.available_years.push('All Time')
  end
end
