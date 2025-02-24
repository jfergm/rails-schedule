require 'rails_helper'

RSpec.describe "appointments/show.html.tailwindcss", type: :view do
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
  it "shows appointment information" do
    visit appointment_path(appointment)

    expect(page).to have_link("Change status", href: status_appointment_path(appointment))

    expect(page).to have_content appointment.code
    expect(page).to have_content appointment.duration
    expect(page).to have_content appointment.status
    expect(page).to have_content appointment.scheduled_at.strftime("%Y-%m-%d %H:%M:%S")
    expect(page).to have_content appointment.user.name
    expect(page).to have_content appointment.client.name
    expect(page).to have_content appointment.location.name
    expect(page).to have_content appointment.location.address
    expect(page).to have_content appointment.location.postal_code
  end
end
