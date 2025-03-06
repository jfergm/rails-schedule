require 'rails_helper'

RSpec.describe "appointments/edit.html.tailwindcss", type: :view do
  include AuthHelper

  let(:appointment) { create(:appointment) }
  before(:each) do
    sign_in_as(create(:user))
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
