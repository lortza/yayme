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
  scope :in_chronological_order, -> { order(date: :asc) }

  def self.search(given_year: '', search_terms: '')
    if given_year.present? && search_terms.present?
      for_words(search_terms).for_year(given_year)
    elsif given_year.present? && search_terms.blank?
      for_year(given_year)
    elsif given_year.blank? && search_terms.present?
      for_words(search_terms)
    else
      for_year(Date.today.year)
    end
  end

  def self.for_words(terms)
    if terms.blank?
      includes(:accomplishment_type).by_date
    else
      includes(:accomplishment_type).where('description ILIKE ? OR given_by ILIKE ?', "%#{terms}%", "%#{terms}%").by_date
    end
  end

  def self.for_year(given_year)
    if given_year.blank? || given_year.to_i == 0
      includes(:accomplishment_type).by_date
    else
      includes(:accomplishment_type).where('extract(year from date) = ?', given_year)
    end
  end

  def self.bookmarked
    where(bookmarked: true)
  end

  def self.in_last_calendar_year
    where('date BETWEEN ? AND ?', Date.today - 365, Date.today)
  end

  def word_cloud
    description.split(' ').each_with_object({}) do |raw_word, hash|
      word = stripped_word(raw_word).downcase
      hash[word].nil? ? hash[word] = 1 : hash[word] += 1
    end
  end

  private

  def stripped_word(word)
    unwanted_characters = %w[: " . ( ) [ ] , … ... ? — -- & ; 0 1 2 3 4 5 6 7 8 9]
    unwanted_characters.each do |mark|
      word = word.gsub(mark, '')
    end
    word
  end
end
