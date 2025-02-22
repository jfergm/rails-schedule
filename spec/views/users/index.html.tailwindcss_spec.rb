require 'rails_helper'

RSpec.describe "users/index.html.tailwindcss", type: :view do
  it "should have add user link" do
    visit users_path

    expect(page).to have_link('Add', href: new_user_path)
  end

  before { User.create(name: 'My name', last_name: 'My last name', email: 'myemail@email.com') }
  context 'Users table' do
    it "should have users table" do
      visit users_path

      expect(page).to have_selector('table#users-table')
    end

    it "should have one row" do
      visit users_path

      expect(page).to have_selector("tbody tr", count: 1)
    end

    it 'user: "My name" should have show, edit, delete links' do
      visit users_path

      expect(page).to have_link('Show', href: user_path(1))
      expect(page).to have_link('Edit', href: edit_user_path(1))
      expect(page).to have_css("form[action='#{user_path(1)}']")
    end
  end
end
