class AccomplishmentTypesController < ApplicationController
  before_action :set_accomplishment_type, only: [:show, :edit, :update, :destroy]

  # GET /accomplishment_types
  # GET /accomplishment_types.json
  def index
    @accomplishment_types = AccomplishmentType.all
  end

  # GET /accomplishment_types/1
  # GET /accomplishment_types/1.json
  def show
  end

  # GET /accomplishment_types/new
  def new
    @accomplishment_type = AccomplishmentType.new
  end

  # GET /accomplishment_types/1/edit
  def edit
  end

  # POST /accomplishment_types
  # POST /accomplishment_types.json
  def create
    @accomplishment_type = AccomplishmentType.new(accomplishment_type_params)

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

  # PATCH/PUT /accomplishment_types/1
  # PATCH/PUT /accomplishment_types/1.json
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

  # DELETE /accomplishment_types/1
  # DELETE /accomplishment_types/1.json
  def destroy
    @accomplishment_type.destroy
    respond_to do |format|
      format.html { redirect_to accomplishment_types_url, notice: 'Accomplishment type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accomplishment_type
      @accomplishment_type = AccomplishmentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accomplishment_type_params
      params.require(:accomplishment_type).permit(:name)
    end
end
