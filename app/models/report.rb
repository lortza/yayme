# frozen_string_literal: true

class Report < ApplicationRecord
  def self.available_years(model = Accomplishment, date_field = :date)
    model.all.pluck(date_field).map(&:year).uniq.sort.reverse
  end

  def self.generate_word_heat_map(accomplishments:, minimum_count:)
    words = accomplishments.each_with_object({}) do |accomplishment, words_hash |
      words_hash.merge!(accomplishment.word_heat_map) do |k, hash_value, incoming_value|
        hash_value + incoming_value
      end
    end
    filtered_words = filter_minimum_count(words, minimum_count)
    filter_out_common(filtered_words)
  end

  private

  def self.filter_minimum_count(words_hash, minimum)
    words_hash.select {|word, count| count >= minimum }
  end

  def self.sort_descending_count(words_hash)
    words_hash.sort_by {|word, count| -count}
  end

  def self.filter_out_common(words_hash)
    common_words = %w[a am an at as and be been for from had have i in is it of on that the this to was]
    words_hash.select {|word, count| common_words.exclude?(word) }
  end

end
