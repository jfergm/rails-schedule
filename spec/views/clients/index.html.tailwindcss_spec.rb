require 'rails_helper'

RSpec.describe "clients/index.html.tailwindcss", type: :view do
  it "shows a link to add client" do
    visit clients_path

    expect(page).to have_link('Add', href: new_client_path)
  end

  before { Client.create(name: "Jhon", last_name: "Doe", email: "client_email@email.com", phone_number: "1234567890") }
  context "clients table" do
    it "shows a clients table" do
      visit clients_path

      expect(page).to have_selector("table#clients-table")
    end

    it "have one client row" do
      visit clients_path

      expect(page).to have_selector("tbody tr", count: 1)
    end

    it "client: 'Jhon' have show, edit and delete items" do
      visit clients_path

      expect(page).to have_link("Show", href: client_path(1))
      expect(page).to have_link("Edit", href: edit_client_path(1))
      expect(page).to have_css("form[action='#{client_path(1)}']")
    end
  end
end
