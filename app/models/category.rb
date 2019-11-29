class Category < ApplicationRecord
  has_many :accomplishment_categories
  has_many :accomplishments, through: :accomplishment_categories
end
