# frozen_string_literal: true

class Accomplishment < ApplicationRecord
  belongs_to :accomplishment_type
  has_many :accomplishment_categories
  has_many :categories, through: :accomplishment_categories

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

  def self.bookmarked
    where(bookmarked: true)
  end

  def self.in_last_calendar_year
    where('date BETWEEN ? AND ?', Date.today - 365, Date.today)
  end

  def word_heat_map
    mapped_words = {}
    description.split(' ').each do |word|
      if mapped_words[word] == nil
        mapped_words[word] = 1
      else
        mapped_words[word] += 1
      end
    end
    mapped_words
  end
end
