# frozen_string_literal: true

class ReportsController < ApplicationController
  def word_heat_map
    @words = Report.generate_word_heat_map(accomplishments: current_user.accomplishments, minimum_count: 7)
  end
end
