# frozen_string_literal: true

class AccomplishmentTypesController < ApplicationController
  before_action :set_accomplishment_type, only: [:show, :edit, :update, :destroy]

  def index
    @accomplishment_types = current_user.accomplishment_types.all
  end

  def show
    @accomplishments = @accomplishment_type.accomplishments.paginate(page: params[:page], per_page: 50)
  end

  def new
    @accomplishment_type = current_user.accomplishment_types.new
  end

  def edit
  end

  def create
    @accomplishment_type = current_user.accomplishment_types.new(accomplishment_type_params)

    respond_to do |format|
      if @accomplishment_type.save
        format.html { redirect_to @accomplishment_type, notice: 'Accomplishment type was successfully created.' }
        format.json { render :show, status: :created, location: @accomplishment_type }
      else
        format.html { render :new }
        format.json { render json: @accomplishment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @accomplishment_type.update(accomplishment_type_params)
        format.html { redirect_to @accomplishment_type, notice: 'Accomplishment type was successfully updated.' }
        format.json { render :show, status: :ok, location: @accomplishment_type }
      else
        format.html { render :edit }
        format.json { render json: @accomplishment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @accomplishment_type.destroy
    respond_to do |format|
      format.html { redirect_to accomplishment_types_url, notice: 'Accomplishment type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_accomplishment_type
    @accomplishment_type = current_user.accomplishment_types.find(params[:id])
  end

  def accomplishment_type_params
    params.require(:accomplishment_type).permit(:name)
  end
end
