class Category < ApplicationRecord
  extend Sortable

  belongs_to :user
  has_many :accomplishment_categories
  has_many :accomplishments, through: :accomplishment_categories
end
