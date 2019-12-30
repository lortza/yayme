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
    @accomplishment = current_user.accomplishments.new
  end

  def edit
  end

  def create
    @accomplishment = current_user.accomplishments.new(accomplishment_params)

    respond_to do |format|
      if @accomplishment.save
        format.html { redirect_to accomplishments_url, notice: "#{@accomplishment.date} #{@accomplishment.accomplishment_type_name} was successfully created." }
        format.json { render :show, status: :created, location: accomplishments_url }
      else
        format.html { render :new }
        format.json { render json: @accomplishment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @accomplishment.update(accomplishment_params)
        format.html { redirect_to accomplishments_url, notice: "#{@accomplishment.date} #{@accomplishment.accomplishment_type_name} was successfully updated." }
        format.json { render :index, status: :ok, location: accomplishments_url }
      else
        format.html { render :edit }
        format.json { render json: @accomplishment.errors, status: :unprocessable_entity }
      end
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
                  :date,
                  :description,
                  :given_by,
                  :url,
                  :bookmarked,
                  category_ids: [])
  end
end
