require 'rails_helper'

RSpec.describe "appointments/edit_status.html.tailwindcss", type: :view do
  include AuthHelper

  let(:appointment) { create(:appointment) }
  before(:each) do
    sign_in_as(create(:user))
  end
  it "shows form with appointment status" do
    visit status_appointment_path(appointment)


    expect(page).to have_field("Status", with: appointment.status)
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{status_appointment_path(appointment)}']")
  end
end
