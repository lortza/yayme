# frozen_string_literal: true

class RaisePrepController < ApplicationController
  def index
    @categories = Category.all
    # @accomplishments = current_user.accomplishments
    #                                .bookmarked
    #                                .in_last_calendar_year
    #                                .for_merit_and_praise
    #                                .paginate(page: params[:page], per_page: 50)
  end
end
