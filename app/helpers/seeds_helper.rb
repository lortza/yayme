# frozen_string_literal: true

module SeedsHelper
  # rubocop:disable Rails/Output
  def self.count_records_for(model)
    puts "Seeding #{model.table_name}"
    starting_record_count = model.count
    starting_time = Time.zone.now

    yield

    ending_count = model.count
    puts "   -> #{ending_count - starting_record_count} new"
    puts "   -> #{ending_count} total"
    puts "   -> #{(Time.zone.now - starting_time).round(3)}s"
  end
  # rubocop:enable Rails/Output
end
