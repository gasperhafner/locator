class CitiesController < ApplicationController
  before_action :authenticate!
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /cities
  def index
    @cities =
      current_user
        .cities
        .order(name: :asc)
        .paginate(page: params[:page], per_page: 30)
  end

  # GET /cities/1
  def show
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  def create
    city = current_user.cities.create(city_params)
    redirect_to edit_city_path(city), notice: 'Polygon was successfully created.'
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      redirect_to edit_city_path, notice: 'Polygon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cities/1
  def destroy
    @city.destroy
    redirect_to cities_url, notice: 'Polygon was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = current_user.cities.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def city_params
    params.require(:city).permit(:name, :surface, :geojson)
  end
end
