require 'rails_helper'

RSpec.describe "users/new.html.tailwindcss", type: :view do
  it "should have user form" do
    visit new_user_path

    expect(page).to have_field("Name")
    expect(page).to have_field("Last name")
    expect(page).to have_field("Email")
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{users_path}']")
  end
end
