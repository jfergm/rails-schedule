require 'rails_helper'

RSpec.describe "appointments/index.html.tailwindcss", type: :view do
  include AuthHelper

  before(:each) do
    sign_in_as(create(:user))
  end
  it "shows a link to add appointment" do
    visit appointments_path

    expect(page).to have_link("Add", href: new_appointment_path)
  end

  before do
    create(:appointment)
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
