class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]
  def index
    @locations = Location.all
  end

  def show
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      flash[:success] = "Location created"
      redirect_to locations_path
    else
      render :new
    end
  end

  def update
    if @location.update(location_params)
      flash[:success] = "Location updated"
      redirect_to locations_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @location.destroy
      flash[:success] = "Location deleted"
      redirect_to locations_path
    rescue
      flash[:error] = "Could not delete location: #{@location.name}"
    end
  end

  private
  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :address, :postal_code, :city, :state, :notes)
  end
end
