# frozen_string_literal: true

class ReportsController < ApplicationController
  def word_cloud
    search_terms = params[:search]
    given_year = params[:given_year]
    accomplishments = current_user.accomplishments.search(given_year: given_year, search_terms: search_terms)

    @words = Report.generate_word_cloud(accomplishments: accomplishments, minimum_count: 5)
  end
end
