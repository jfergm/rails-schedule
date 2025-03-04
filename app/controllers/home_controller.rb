class HomeController < ApplicationController
  def index
    @appointments = Appointment
    @users = User
    @clients = Client
    @locations = Location
  end
end
