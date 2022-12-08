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
# rubocop:disable Rails/UniqueValidationWithoutIndex
class PostType < ApplicationRecord
  extend Sortable

  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id }

  def self.merit_or_praise
    raise_types = PostType.where('name ILIKE ? OR name ILIKE ?', '%merit%', '%praise%')
    where('post_type IN ?', raise_types)
  end
end
# rubocop:enable Rails/UniqueValidationWithoutIndex
