class AccomplishmentsController < ApplicationController
  before_action :set_accomplishment, only: [:edit, :update, :destroy]

  def index
    @accomplishments = Accomplishment.all
  end

  def new
    @accomplishment = Accomplishment.new
  end

  def edit
  end

  def create
    @accomplishment = Accomplishment.new(accomplishment_params)

    respond_to do |format|
      if @accomplishment.save
        format.html { redirect_to accomplishments_url, notice: 'Accomplishment was successfully created.' }
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
        format.html { redirect_to accomplishments_url, notice: 'Accomplishment was successfully updated.' }
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
      format.html { redirect_to accomplishments_url, notice: 'Accomplishment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_accomplishment
      @accomplishment = Accomplishment.find(params[:id])
    end

    def accomplishment_params
      params.require(:accomplishment).permit(:description, :accomplishment_type_id, :url, :bookmarked)
    end
end
