# frozen_string_literal: true

class AccomplishmentsController < ApplicationController
  before_action :set_accomplishment, only: %i[edit update destroy]

  def index
    search_terms = params[:search]
    given_year = params[:given_year]

    @accomplishments = current_user.accomplishments
                                   .search(given_year: given_year, search_terms: search_terms)
                                   .by_date
                                   .paginate(page: params[:page], per_page: 50)
  end

  def new
    @accomplishment = current_user.accomplishments.new(date: Time.zone.today)
  end

  def edit
  end

  def create
    @accomplishment = current_user.accomplishments.new(accomplishment_params)

    if @accomplishment.save
      redirect_to accomplishments_url
      # redirect_back(fallback_location: accomplishments_url,
      #               notice: "#{@accomplishment.date} #{@accomplishment.accomplishment_type_name} was successfully created.")
    else
      render :new
    end
  end

  def update
    if @accomplishment.update(accomplishment_params)
      redirect_to accomplishments_url, notice: "#{@accomplishment.date} #{@accomplishment.accomplishment_type_name} was successfully updated."
      # redirect_back(fallback_location: accomplishments_url,
      #               notice: "#{@accomplishment.date} #{@accomplishment.accomplishment_type_name} was successfully updated.")
    else
      render :edit
    end
  end

  def destroy
    @accomplishment.destroy
    respond_to do |format|
      format.html { redirect_to accomplishments_url, notice: "#{@accomplishment.date} #{@accomplishment.accomplishment_type_name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_accomplishment
    @accomplishment = current_user.accomplishments.find(params[:id])
  end

  def accomplishment_params
    params.require(:accomplishment)
          .permit(:accomplishment_type_id,
                  :bookmarked,
                  :date,
                  :description,
                  :given_by,
                  :image_url,
                  :url,
                  category_ids: [])
  end
end
