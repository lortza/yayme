# frozen_string_literal: true

class AccomplishmentTypesController < ApplicationController
  before_action :set_accomplishment_type, only: %i[show edit update destroy]

  def index
    @accomplishment_types = current_user.accomplishment_types.all
  end

  def show
    search_terms = params[:search]
    given_year = params[:given_year]

    @accomplishments = @accomplishment_type.accomplishments
                                           .search(given_year: given_year, search_terms: search_terms)
                                           .by_date
                                           .paginate(page: params[:page], per_page: 50)
  end

  def new
    @accomplishment_type = current_user.accomplishment_types.new
  end

  def edit
  end

  def create
    @accomplishment_type = current_user.accomplishment_types.new(accomplishment_type_params)

    if @accomplishment_type.save
      redirect_to @accomplishment_type
    else
      render :new
    end
  end

  def update
    if @accomplishment_type.update(accomplishment_type_params)
      redirect_to accomplishment_types_url
    else
      render :edit
    end
  end

  def destroy
    @accomplishment_type.destroy
    redirect_to accomplishment_types_url, notice: "Accomplishment type #{@accomplishment_type.name} was destroyed."
  end

  private

  def set_accomplishment_type
    @accomplishment_type = current_user.accomplishment_types.find(params[:id])
  end

  def accomplishment_type_params
    params.require(:accomplishment_type).permit(:name, :description_template)
  end
end
