# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  bookmarked   :boolean          default(FALSE)
#  date         :date             not null
#  description  :text
#  given_by     :text
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  post_type_id :bigint           not null
#
# Indexes
#
#  index_posts_on_post_type_id  (post_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_type_id => post_types.id)
#
FactoryBot.define do
  factory :post do
    post_type_id { create(:post_type).id }
    sequence(:date) { Time.zone.today - rand(0..10) }
    sequence(:description) { |n| "Lorem ipsum dolor sit amet, consectetur do adipisicing elit, sit sed do eiusmod#{n}" }
    sequence(:with_people) { |n| "GivenBy Name#{n}" }
    sequence(:url) { |n| "http://www.url#{n}.com" }
    bookmarked { false }
  end
end
