# frozen_string_literal: true

module PostsHelper
  def years_dropdown
    Report.available_years.push('All Time')
  end

  def display_categories(post)
    post.categories.map(&:name).join(', ')
  end
end
