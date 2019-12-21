# frozen_string_literal: true

class ReportsController < ApplicationController
  def word_cloud
    accomplishments = current_user.accomplishments.for_year(params[:given_year])
    @words = Report.generate_word_cloud(accomplishments: accomplishments, minimum_count: 5)
  end
end
