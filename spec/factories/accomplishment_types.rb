# frozen_string_literal: true

FactoryBot.define do
  factory :accomplishment_types do
    user_id { create(:user).id }
    sequence(:name) { |n| "accomplishment type#{n}" }
  end
end
