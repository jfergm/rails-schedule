require 'rails_helper'

RSpec.describe "users/show.html.tailwindcss", type: :view do
  include AuthHelper

  let(:user) { create(:user) }

  before(:each) do
    sign_in_as(user)
  end

  it "must show user information" do
    visit user_path(user)

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.email)
  end
end
