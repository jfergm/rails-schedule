require 'rails_helper'

RSpec.describe "locations/index.html.tailwindcss", type: :view do
  include AuthHelper

  before(:each) do
    sign_in_as(create(:user))
  end
  it "shows a link to add location" do
    visit locations_path

    expect(page).to have_link('Add', href: new_location_path)
  end

  before do
    create(:location)
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
