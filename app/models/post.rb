# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :post_type
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  validates :date,
            :description,
            :post_type,
            presence: true

  before_save :format_image_url

  delegate :name, to: :post_type, prefix: true

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
      for_year(Time.zone.today.year)
    end
  end

  def self.for_words(terms)
    if terms.blank?
      includes(:post_type).by_date
    else
      includes(:post_type).where('description ILIKE ? OR given_by ILIKE ?', "%#{terms}%", "%#{terms}%").by_date
    end
  end

  def self.for_year(given_year)
    if given_year.blank? || given_year.to_i.zero?
      includes(:post_type).by_date
    else
      includes(:post_type).where('extract(year from date) = ?', given_year)
    end
  end

  def self.for_merit_and_praise
    includes(:post_type)
      .joins(:post_type)
      .where('post_types.name ILIKE ? OR post_types.name ILIKE ?', '%merit%', '%praise%')
  end

  def self.for_gratitude_and_praise
    includes(:post_type)
      .joins(:post_type)
      .where('post_types.name ILIKE ? OR post_types.name ILIKE ?', '%gratitude%', '%praise%')
  end

  def self.bookmarked
    where(bookmarked: true)
  end

  def self.in_last_calendar_year
    where('date BETWEEN ? AND ?', Time.zone.today - 365, Time.zone.today)
  end

  def word_cloud
    description.split(' ').each_with_object({}) do |raw_word, hash|
      word = stripped_word(raw_word).downcase
      hash[word].nil? ? hash[word] = 1 : hash[word] += 1
    end
  end

  def format_image_url
    self.image_url = image_url.present? ? DropboxApi.format_url(self.image_url) : ''
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
