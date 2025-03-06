require 'rails_helper'

RSpec.describe "appointments/show.html.tailwindcss", type: :view do
  include AuthHelper

  let(:appointment) { create(:appointment) }
  before(:each) do
    sign_in_as(create(:user))
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
