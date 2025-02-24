class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show edit update destroy edit_status update_status]
  def index
    @appointments = Appointment.all
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def edit
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      flash[:success] = "Appointment created"
      redirect_to appointments_path
    else
      render :new
    end
  end

  def update
    if @appointment.update(appointment_params)
      flash[:success] = "Appointment updated"
      redirect_to appointments_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @appointment.destroy
      flash[:success] = "Appointment deleted"
      redirect_to appointments_path
    rescue
      flash[:error] = "Could not delete appointment #{@appointment.scheduled_at}"
    end
  end

  def edit_status
  end

  def update_status
    if @appointment.update(appointment_status)
      flash[:success] = "Appointment status changed"
      redirect_to appointment_path(@appointment)
    else
      render :edit_status
    end
  end

  private
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :client_id, :location_id, :scheduled_at, :duration, :notes)
  end
  def appointment_status
    params.require(:appointment).permit(:status)
  end
end
