require 'rails_helper'

RSpec.describe "locations/index.html.tailwindcss", type: :view do
  it "shows a link to add location" do
    visit locations_path

    expect(page).to have_link('Add', href: new_location_path)
  end

  before do
    Location.create(
      name: "Main location",
      address: "Main st 23",
      postal_code: "00000",
      city: "Main city",
      state: "Main state",
      notes: "Notes..."
    )
  end
  context "locations table" do
    it "shows a location table" do
      visit locations_path

      expect(page).to have_selector("table#locations-table")
    end

    it "have one location row" do
      visit locations_path

      expect(page).to have_selector("tbody tr", count: 1)
    end

    it "location: 'Main location' have show, edit and delete items" do
      visit locations_path

      expect(page).to have_link("Show", href: location_path(1))
      expect(page).to have_link("Edit", href: edit_location_path(1))
      expect(page).to have_css("form[action='#{location_path(1)}']")
    end
  end
end
