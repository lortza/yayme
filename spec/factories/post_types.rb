# frozen_string_literal: true

# == Schema Information
#
# Table name: post_types
#
#  id                   :bigint           not null, primary key
#  description_template :text
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_post_types_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :post_type do
    user_id                         { create(:user).id }
    sequence(:name)                 { |n| "post type#{n}" }
    sequence(:description_template) { |n| "##template heading#{n}" }
  end
end
