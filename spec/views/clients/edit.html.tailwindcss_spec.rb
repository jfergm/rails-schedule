require 'rails_helper'

RSpec.describe "clients/edit.html.tailwindcss", type: :view do
  include AuthHelper

  let(:client) { create(:client) }

  before(:each) do
    sign_in_as(create(:user))
  end
  it "have the edit client form filled" do
    visit edit_client_path(client)

    expect(page).to have_field("Name", with: client.name)
    expect(page).to have_field("Last name", with: client.last_name)
    expect(page).to have_field("Email", with: client.email)
    expect(page).to have_field("Phone number", with: client.phone_number)
    expect(page).to have_css("input[type=submit]")
    expect(page).to have_css("form[action='#{client_path(client)}']")
  end
end
