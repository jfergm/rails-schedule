require 'rails_helper'

RSpec.describe "index.html.tailwindcss", type: :view do
  it "should have home link" do
    visit root_path

    expect(page).to have_link('Home', href: root_path)
  end

  it "should have users link" do
    visit root_path

    expect(page).to have_link('Users', href: users_path)
  end

  it "should have clients link" do
    visit root_path

    expect(page).to have_link('Clients', href: clients_path)
  end
  it "should have locations link" do
    visit root_path

    expect(page).to have_link('Locations', href: locations_path)
  end
end
