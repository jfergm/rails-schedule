require 'rails_helper'

RSpec.describe "clients/new.html.tailwindcss", type: :view do
  include AuthHelper

  before(:each) do
    sign_in_as(create(:user))
  end
  it "shows new client form" do
    visit new_client_path

    expect(page).to have_field("Name")
    expect(page).to have_field("Last name")
    expect(page).to have_field("Email")
    expect(page).to have_field("Phone number")
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{clients_path}']")
  end
end
