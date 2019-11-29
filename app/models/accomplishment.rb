class Accomplishment < ApplicationRecord
  belongs_to :accomplishment_type

  validates :date,
            :description,
            :accomplishment_type,
            presence: true

  delegate :name, to: :accomplishment_type, prefix: true

  scope :by_date, -> { order(date: :desc) }

  def self.search(terms)
    if terms.blank?
      all
    else
      where('description ILIKE ?', "%#{terms}%")
    end
  end
end
