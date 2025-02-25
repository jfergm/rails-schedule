require 'rails_helper'

RSpec.describe "locations/new.html.tailwindcss", type: :view do
  it "shows new location form" do
    visit new_location_path

    expect(page).to have_field("Name")
    expect(page).to have_field("Address")
    expect(page).to have_field("Postal code")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Notes")
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{locations_path}']")
  end
end
