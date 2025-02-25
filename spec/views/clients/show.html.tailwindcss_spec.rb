require 'rails_helper'

RSpec.describe "clients/show.html.tailwindcss", type: :view do
  let(:client) { Client.create(name: "Jhon", last_name: "Doe", email: "client_email@email.com", phone_number: "1234567890") }

  it "shows client information" do
    visit client_path(client.id)

    expect(page).to have_content client.name
    expect(page).to have_content client.last_name
    expect(page).to have_content client.email
    expect(page).to have_content client.phone_number
  end
end
