require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  include AuthHelper

  let(:appointment) do
    create(:appointment)
  end


  before(:each) do
    sign_in_as(create(:user))
  end

  describe "GET /appointments" do
    it "returns http success" do
      get "/appointments"
      expect(response).to have_http_status(:success)
    end

    it "renders index template" do
      get "/appointments"

      expect(response).to render_template :index
    end
  end

  describe "GET /appointments/:id" do
    it "returns http success" do
      get "/appointments/#{appointment.id}"
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      get "/appointments/#{appointment.id}"

      expect(response).to render_template :show
    end
  end

  describe "GET /appointments/new" do
    it "returns http success" do
      get "/appointments/new"
      expect(response).to have_http_status(:success)
    end

    it "render new template" do
      get "/appointments/new"

      expect(response).to render_template :new
    end
  end

  describe "GET appointments/:id/edit" do
    it "returns http success" do
      get "/appointments/#{appointment.id}/edit"
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get "/appointments/#{appointment.id}/edit"

      expect(response).to render_template :edit
    end
  end

  before do
    create(:user, id: 123)
    create(:client, id: 321)
    create(:location, id: 213)
  end
  describe "POST /appointments" do
    it "creates an appointment with valid data" do
      post "/appointments", params: {
        appointment: {
          user_id: 123,
          client_id: 321,
          location_id: 213,
          scheduled_at: Time.current,
          duration: 30
        }
      }

      expect(response).to redirect_to appointments_path
      expect(flash[:success]).to eq "Appointment created"
    end

    it "not creates an appointment with invalid data" do
      post "/appointments", params: { appointment: { user: nil, client: nil, location: nil, scheduled_at: nil } }

      expect(response).to render_template :new
    end
  end

  describe "PATCH /appointments/:id" do
    it "updates an appoinmtnet with valid data" do
      patch "/appointments/#{appointment.id}", params: { appointment: { scheduled_at: "2025-03-03 15:00" } }

      expect(response).to redirect_to appointments_path
      expect(flash[:success]).to eq "Appointment updated"
    end

    it "not updates an appointment with invalid data" do
      patch "/appointments/#{appointment.id}", params: { appointment: { scheduled_at: nil } }

      expect(response).to render_template :edit
    end
  end

  describe "DELETE /appointments/:id" do
    it "deletes an appointment" do
      delete "/appointments/#{appointment.id}"

      expect(flash[:success]).to eq "Appointment deleted"
    end
  end

  describe "GET /appointments/:id/change_status" do
    it "returns http success" do
      get "/appointments/#{appointment.id}/status"
      expect(response).to have_http_status(:success)
    end

    it "renders change_status template" do
      get "/appointments/#{appointment.id}/status"

      expect(response).to render_template :edit_status
    end
  end

  describe "PATCH /appointments/:id/change_status" do
    it "Changes the appointment status to finished" do
      patch "/appointments/#{appointment.id}/status", params: { appointment: { status: :finished } }

      expect(response).to redirect_to appointment_path(appointment)
      expect(flash[:success]).to eq "Appointment status changed"
    end

    it "Changes the appointment status to cancelled" do
      patch "/appointments/#{appointment.id}/status", params: { appointment: { status: :cancelled } }

      expect(response).to redirect_to appointment_path(appointment)
      expect(flash[:success]).to eq "Appointment status changed"
    end
  end
end
