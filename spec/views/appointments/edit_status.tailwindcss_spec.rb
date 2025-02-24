require 'rails_helper'

RSpec.describe "appointments/edit_status.html.tailwindcss", type: :view do
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
      status: 0,
      duration: 30,
      notes: "Appointment notes"
    )
  end
  it "shows form with appointment status" do
    visit status_appointment_path(appointment)


    expect(page).to have_field("Status", with: appointment.status)
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{status_appointment_path(appointment)}']")
  end
end
