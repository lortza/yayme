# frozen_string_literal: true

class Report
  TIMEFRAMES = {
    "Past Week" => 7,
    "Past Month" => 30,
    "Past Quarter" => 90,
    "Past Half Year" => 182,
    "Past Year" => 365,
    "All Time" => nil
  }.freeze

  class << self
    def timeframe_labels
      TIMEFRAMES.keys
    end

    def this_year
      Date.current.year
    end

    def available_years(model = Post, date_field = :date)
      model.all.pluck(date_field).map(&:year).uniq.sort.reverse
    end

    def generate_word_cloud(user:, search_params:, minimum_count:)
      posts = user.posts.search(**search_params)

      words = posts.each_with_object({}) do |post, words_hash|
        words_hash.merge!(post.word_cloud) do |_k, hash_value, incoming_value|
          hash_value + incoming_value
        end
      end

      filtered_words = filter_minimum_count(words, minimum_count)
      filtered_words = filter_out_common(filtered_words)
      filtered_words = filter_out_code_artifacts(filtered_words)
      filter_out_template_words(filtered_words, user)
    end

    private

    def filter_minimum_count(words_hash, minimum)
      words_hash.select { |_word, count| count >= minimum }
    end

    def sort_descending_count(words_hash)
      words_hash.sort_by { |_word, count| -count }
    end

    def filter_out_common(words_hash)
      common_words = %w[
        a am an and are as at
        be been being but by
        can could
        did do does doing done
        for from
        had has have having he her here hers herself him himself his how
        i if in into is it its itself
        just
        me my myself
        of on or our ours ourselves out over
        really
        said same she should so some such
        than that the their theirs them themselves then there these they this those through to too
        up us
        very
        was we were what when where which while who whom why will with would
        you your yours yourself yourselves
      ]

      # Also filter short words (1-2 characters) and numeric-only strings
      words_hash.reject do |word, _count|
        common_words.include?(word) || word.length <= 2 || word.match?(/^\d+$/)
      end
    end

    def filter_out_code_artifacts(words_hash)
      words_hash.reject do |word, _count|
        # Filter out HTML/XML tags
        word.match?(/^<\/?[a-z][a-z0-9]*>?$/i) ||
          # Filter out words that are mostly special characters (like {}, [], etc.)
          word.match?(/^[^a-z]*$/i) ||
          # Filter out words containing HTML entities
          word.include?("&") ||
          # Filter out common code keywords that might slip through
          %w[div span href src alt class style function const let var return].include?(word)
      end
    end

    def filter_out_template_words(words_hash, user)
      template_words = extract_all_template_words(user)
      words_hash.except(*template_words)
    end

    def extract_all_template_words(user)
      user.post_types
        .where.not(description_template: [nil, ""])
        .pluck(:description_template)
        .flat_map { |template| extract_words_from_text(template) }
        .uniq
    end

    def extract_words_from_text(text)
      # Remove code blocks first
      cleaned_text = text.gsub(/```.*?```/m, " ")

      cleaned_text.split.map { |word|
        stripped = strip_punctuation(word).downcase
        stripped if stripped.length > 2 # Only include words longer than 2 chars
      }.compact
    end

    def strip_punctuation(word)
      unwanted = %w[: " . ( ) [ ] , … ... ? ! — -- ``` & ; 0 1 2 3 4 5 6 7 8 9]
      unwanted.each { |mark| word = word.gsub(mark, "") }
      word
    end
  end
end
