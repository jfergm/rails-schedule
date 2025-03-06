require 'rails_helper'

RSpec.describe "users/edit.html.tailwindcss", type: :view do
  include AuthHelper

  let(:user) { create(:user) }

  before(:each) do
    sign_in_as(user)
  end
  it "should have the user form filled" do
    visit edit_user_path(user)

    expect(page).to have_field("Name", with: user.name)
    expect(page).to have_field("Last name", with: user.last_name)
    expect(page).to have_field("Email", with: user.email)
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{user_path(user)}']")
  end
end
