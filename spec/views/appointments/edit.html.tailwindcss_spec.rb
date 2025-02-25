require 'rails_helper'

RSpec.describe "appointments/edit.html.tailwindcss", type: :view do
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
      scheduled_at: Time.local(2025, 02, 20, 14, 30),
      status: 0,
      duration: 30,
      notes: "Appointment notes"
    )
  end
  it "have the appointment form filled" do
    visit edit_appointment_path(appointment)

    expect(page).to have_field("User", with: appointment.user.id)
    expect(page).to have_field("Client", with: appointment.client.id)
    expect(page).to have_field("Location", with: appointment.location.id)
    expect(page).to have_field("Scheduled at", with: appointment.scheduled_at.strftime("%Y-%m-%dT%H:%M:%S"))
    expect(page).to have_field("Duration", with: appointment.duration)
    expect(page).to have_field("Notes", with: appointment.notes)
  end
end
