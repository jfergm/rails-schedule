require 'rails_helper'

RSpec.describe "locations/edit.html.tailwindcss", type: :view do
  include AuthHelper

  let(:location) { create(:location) }
  before(:each) do
    sign_in_as(create(:user))
  end
  it "shows form with location info filled" do
    visit edit_location_path(location)

    expect(page).to have_field("Name", with: location.name)
    expect(page).to have_field("Address", with: location.address)
    expect(page).to have_field("Postal code", with: location.postal_code)
    expect(page).to have_field("City", with: location.city)
    expect(page).to have_field("State", with: location.state)
    expect(page).to have_field("Notes", with: location.notes)
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{location_path(location)}']")
  end
end
