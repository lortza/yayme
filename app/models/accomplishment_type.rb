class AccomplishmentType < ApplicationRecord
  belongs_to :user
  has_many :accomplishments, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id }
end
