# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  bookmarked   :boolean          default(FALSE)
#  date         :date             not null
#  description  :text
#  given_by     :text
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  post_type_id :bigint           not null
#
# Indexes
#
#  index_posts_on_post_type_id  (post_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_type_id => post_types.id)
#
require "csv"

class Post < ApplicationRecord
  belongs_to :post_type
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_one_attached :image

  validate :acceptable_image
  validates :date,
    :description,
    presence: true

  attr_accessor :remove_attached_image
  after_save :purge_attached_image, if: :remove_attached_image?

  delegate :name, to: :post_type, prefix: true
  alias_attribute :with_people, :given_by

  scope :in_post_type_ids, ->(ids) { where(post_type_id: ids) }
  scope :in_category_ids, ->(ids) { joins(:categories).where("post_categories.category_id IN (?)", ids) }
  scope :bookmarked, -> { where(bookmarked: true) }
  scope :by_date, -> { order(date: :desc) }
  scope :in_chronological_order, -> { order(date: :asc) }

  def self.search(year: "", text: "", bookmarked: nil)
    return for_year(Report.this_year) if year.blank? && text.blank? && bookmarked.nil?

    posts = for_words(text)
    posts = Report.timeframe_labels.include?(year) ? posts.for_timeframe(year) : posts.for_year(year)
    posts = posts.bookmarked if bookmarked.present?
    posts
  end

  def self.filter_for_export(timeframe: "All Time", text: "", post_type_ids: [], bookmarked: nil, with_people: "", category_ids: [])
    posts = all
    return [] if posts.blank?

    posts = Report.timeframe_labels.include?(timeframe) ? for_timeframe(timeframe) : for_year(timeframe)
    posts = posts.in_post_type_ids(post_type_ids) if posts.present? && post_type_ids.present?
    posts = posts.for_words(text) if posts.present? && text.present?
    posts = posts.for_words(with_people) if posts.present? && with_people.present?
    posts = posts.bookmarked if posts.present? && !bookmarked.nil?
    posts = posts.in_category_ids(category_ids) if posts.present? && category_ids.present?
    posts = posts.by_date if posts.present?
    posts
  end

  def self.for_words(text)
    if text.blank?
      includes(:post_type).by_date
    else
      concat_statement = "concat_ws(' ', description, given_by)"
      includes(:post_type).where("#{concat_statement} ILIKE ?", "%#{text}%").by_date
    end
  end

  def self.for_year(year)
    if year.blank? || year.to_i.zero?
      includes(:post_type).by_date
    else
      includes(:post_type).where("extract(year from date) = ?", year)
    end
  end

  def self.for_timeframe(year)
    qty_days = Report::TIMEFRAMES[year]

    if qty_days.blank?
      includes(:post_type).by_date
    else
      includes(:post_type)
        .where("date >= ? AND date <= ?", qty_days.days.ago, Time.zone.now)
        .by_date
    end
  end

  def self.for_merit_and_praise
    includes(:post_type)
      .joins(:post_type)
      .where("post_types.name ILIKE ? OR post_types.name ILIKE ?", "%merit%", "%praise%")
  end

  def self.for_gratitude_and_praise
    includes(:post_type)
      .joins(:post_type)
      .where("post_types.name ILIKE ? OR post_types.name ILIKE ?", "%gratitude%", "%praise%")
  end

  def self.in_last_calendar_year
    where("date BETWEEN ? AND ?", Time.zone.today - 365, Time.zone.today)
  end

  def self.to_csv
    headers = new.attributes.keys + %w[post_type categories user exported_at]
    CSV.generate(headers: true) do |csv|
      csv << headers
      find_each do |post|
        updated_attributes = post.attributes.merge(
          post_type: post.post_type_name,
          categories: post.categories.map(&:name),
          user: post.post_type.user.name,
          exported_at: Time.zone.now
        )
        csv << updated_attributes.values
      end
    end
  end

  def word_cloud
    description.split.each_with_object({}) do |raw_word, hash|
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

    acceptable_types = ["image/jpeg", "image/jpg", "image/png"]
    errors.add(:image, "must be a JPEG or PNG") unless acceptable_types.include?(image.content_type)
  end

  private

  def remove_attached_image?
    remove_attached_image == "1"
  end

  def purge_attached_image
    image.purge_later
  end

  def stripped_word(word)
    unwanted_characters = %w[: " . ( ) [ ] , … ... ? — -- ``` & ; 0 1 2 3 4 5 6 7 8 9]
    unwanted_characters.each do |mark|
      word = word.gsub(mark, "")
    end
    word
  end
end
