# frozen_string_literal: true

class Category < ApplicationRecord
  extend Sortable

  belongs_to :user
  has_many :post_categories
  has_many :posts, through: :post_categories
end
