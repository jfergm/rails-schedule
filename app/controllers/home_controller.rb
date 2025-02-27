class HomeController < ApplicationController
  def index
    @appointments = Appointment.all
    @users = User.all
    @clients = Client.all
    @locations = Location.all
  end
end
