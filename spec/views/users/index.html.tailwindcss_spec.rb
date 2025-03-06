require 'rails_helper'

RSpec.describe "users/index.html.tailwindcss", type: :view do
  include AuthHelper

  let(:user) { create(:user) }
  before(:each) do
    sign_in_as(user)
  end

  it "should have add user link" do
    visit users_path

    expect(page).to have_link('Add', href: new_user_path)
  end

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
