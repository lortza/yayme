# frozen_string_literal: true

FactoryBot.define do
  factory :accomplishment do
    accomplishment_type_id { create(:accomplishment_type).id }
    sequence(:date) { Time.zone.today - rand(0..10) }
    sequence(:description) { |n| "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod#{n}" }
    sequence(:given_by) { |n| "GivenBy Name#{n}" }
    sequence(:url) { |n| "http://www.url#{n}.com" }
    bookmarked { false }
  end
end
