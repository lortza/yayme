# frozen_string_literal: true

FactoryBot.define do
  factory :accomplishment_type do
    user_id                         { create(:user).id }
    sequence(:name)                 { |n| "accomplishment type#{n}" }
    sequence(:description_template) { |n| "##template heading#{n}" }
  end
end
