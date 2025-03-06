require 'rails_helper'

RSpec.describe "appointments/new.html.tailwindcss", type: :view do
  include AuthHelper

  before(:each) do
    sign_in_as(create(:user))
  end
  it "" do
    visit new_appointment_path

    expect(page).to have_field("User")
    expect(page).to have_field("Client")
    expect(page).to have_field("Location")
    expect(page).to have_field("Scheduled at")
    expect(page).to have_field("Duration")
    expect(page).to have_field("Notes")
    end
end
