require 'rails_helper'

RSpec.describe "appointments/index.html.tailwindcss", type: :view do
  it "shows a link to add appointment" do
    visit appointments_path

    expect(page).to have_link("Add", href: new_appointment_path)
  end

  before do
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
  context "appointments table" do
    it "shows an appointment table" do
      visit appointments_path

      expect(page).to have_selector("table#appointments-table")
    end

    it "have an appointment row" do
      visit appointments_path

      expect(page).to have_selector("tbody tr", count: 1)
    end

    it "have links to show, edit and delete" do
      visit appointments_path

      expect(page).to have_link("Show", href: appointment_path(1))
      expect(page).to have_link("Edit", href: edit_appointment_path(1))
      expect(page).to have_css("form[action='#{appointment_path(1)}']")
    end
  end
end
