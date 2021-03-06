# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :post_type
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_one_attached :image

  validate :acceptable_image
  validates :date,
            :description,
            :post_type,
            presence: true

  attr_accessor :remove_attached_image
  after_save :purge_attached_image, if: :remove_attached_image?

  delegate :name, to: :post_type, prefix: true
  alias_attribute :with_people, :given_by

  scope :bookmarked, -> { where(bookmarked: true) }
  scope :by_date, -> { order(date: :desc) }
  scope :in_chronological_order, -> { order(date: :asc) }

  def self.search(year: '', text: '', bookmarked: nil)
    return for_year(Report.this_year) if year.blank? && text.blank? && bookmarked.nil?

    posts = for_words(text)
    posts = Report.timeframe_labels.include?(year) ? posts.for_timeframe(year) : posts.for_year(year)
    posts = posts.bookmarked if bookmarked.present?
    posts
  end

  def self.for_words(terms)
    if terms.blank?
      includes(:post_type).by_date
    else
      includes(:post_type).where('description ILIKE ? OR given_by ILIKE ?', "%#{terms}%", "%#{terms}%").by_date
    end
  end

  def self.for_year(year)
    if year.blank? || year.to_i.zero?
      includes(:post_type).by_date
    else
      includes(:post_type).where('extract(year from date) = ?', year)
    end
  end

  def self.for_timeframe(year)
    qty_days = Report::TIMEFRAMES[year]

    if qty_days.blank?
      includes(:post_type).by_date
    else
      includes(:post_type)
        .where('date >= ? AND date <= ?', qty_days.days.ago, Time.zone.now)
        .by_date
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

  def acceptable_image
    return unless image.attached?

    if image.byte_size > 1.megabyte
      image_size = (image.byte_size / 1_000_000.0).round(2)
      errors.add(:image, "size #{image_size} MB exceeds 1 MB limit")
    end

    acceptable_types = ['image/jpeg', 'image/jpg', 'image/png']
    errors.add(:image, 'must be a JPEG or PNG') unless acceptable_types.include?(image.content_type)
  end

  private

  def remove_attached_image?
    remove_attached_image == '1'
  end

  def purge_attached_image
    image.purge_later
  end

  def stripped_word(word)
    unwanted_characters = %w[: " . ( ) [ ] , … ... ? — -- & ; 0 1 2 3 4 5 6 7 8 9]
    unwanted_characters.each do |mark|
      word = word.gsub(mark, '')
    end
    word
  end
end
