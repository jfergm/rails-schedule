require 'rails_helper'

RSpec.describe "clients/show.html.tailwindcss", type: :view do
  include AuthHelper

  let(:client) { create(:client) }

  before(:each) do
    sign_in_as(create(:user))
  end
  it "shows client information" do
    visit client_path(client.id)

    expect(page).to have_content client.name
    expect(page).to have_content client.last_name
    expect(page).to have_content client.email
    expect(page).to have_content client.phone_number
  end
end
