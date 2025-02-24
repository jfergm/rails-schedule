require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  let(:appointment) do
    u = User.create(id: 7, name: 'User', last_name: 'Seven', email: 'userone@email.com')
    c = Client.create(id: 23, name: 'Client', last_name: 'TwentyThree', email: 'clientone@email.com', phone_number: "1234567890")
    l = Location.create(
      id: 134,
      name: "Place one",
      address: "Main street 1",
      postal_code: "99999",
      city: "City three",
      state: "State four",
      notes: "The place is between the other place"
    )

    Appointment.create(
      user: u,
      client: c,
      location: l,
      scheduled_at: Time.gm(2025, 02, 20, 14, 30),
      duration: 30,
      notes: "Appointment notes"
    )
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
    User.create(id: 123, name: "User", email: "user@email.com")
    Client.create(id: 321, name: "Client", email: "client@email.com", phone_number: "1234567890")
    Location.create(id: 213, name: "Location 1", address: "One street", postal_code: "00000", city: "City", state: "State")
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
      expect(flash[:success]).to eq nil
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
      expect(flash[:success]).to eq nil
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
