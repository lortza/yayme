# frozen_string_literal: true

FactoryBot.define do
  factory :accomplishment do
    accomplishment_type_id { create(:accomplishment_type).id }
    sequence(:date) { Date.today - rand(0..10) }
    sequence(:description) { |n| "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. #{n}" }
    sequence(:given_by) { |n| "GivenBy Name#{n}" }
    sequence(:url) { |n| "http://www.url#{n}.com" }
    bookmarked { false }
  end
end
