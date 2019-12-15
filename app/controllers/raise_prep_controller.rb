# frozen_string_literal: true

class RaisePrepController < ApplicationController

  def index
    @accomplishments = current_user.accomplishments
                                   .bookmarked
                                   .in_last_calendar_year
                                   .includes(:accomplishment_type)
                                   .joins(:accomplishment_type)
                                   .where('accomplishment_types.name ILIKE ? OR accomplishment_types.name ILIKE ?', "%merit%", "%praise%")
                                   .paginate(page: params[:page], per_page: 50)
  end


end
