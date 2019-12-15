# frozen_string_literal: true

class Report < ApplicationRecord
  def self.generate_word_heat_map(accomplishments)
    # each_with_object  , reduce
    mapped_words = {}
    accomplishments.each do |accomplishment|
      incoming_hash = accomplishment.word_heat_map

      mapped_words.merge!(incoming_hash) do |k, mapped_value, incoming_value|
        mapped_value + incoming_value
      end
    end
    mapped_words.sort_by {|word, count| -count}
  end
end
