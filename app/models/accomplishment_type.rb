class AccomplishmentType < ApplicationRecord
  belongs_to :user
  has_many :accomplishments, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id }

  def self.is_merit_or_praise
    raise_types = AccomplishmentType.where('name ILIKE ? OR name ILIKE ?', "%merit%", "%praise%")
    where('accomplishment_type IN ?', raise_types)
  end
end
