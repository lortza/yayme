# frozen_string_literal: true

# == Schema Information
#
# Table name: post_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  post_id     :bigint           not null
#
# Indexes
#
#  index_post_categories_on_category_id  (category_id)
#  index_post_categories_on_post_id      (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (post_id => posts.id)
#
require "rails_helper"

RSpec.describe PostCategory, type: :model do
  context "associations" do
    it { should belong_to(:post) }
    it { should belong_to(:category) }
  end
end
