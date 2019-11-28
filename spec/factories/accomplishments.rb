# frozen_string_literal: true

FactoryBot.define do
  factory :accomplishments do
    user_id { create(:user).id }
    sequence(:name) { |n| "aisle name #{n}" }
    sequence(:order_number) { |n| n }
  end
end
