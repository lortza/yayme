class AccomplishmentType < ApplicationRecord
  belongs_to :user
  has_many :accomplishments, dependent: :destroy
end
