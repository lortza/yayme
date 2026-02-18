# frozen_string_literal: true

class RaisePrepController < ApplicationController
  def index
    @pagy, @categories = pagy(current_user.categories.all)
  end
end
