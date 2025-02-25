require 'rails_helper'

RSpec.describe "users/show.html.tailwindcss", type: :view do
  let(:user) { User.create(name: "Jhon", last_name: "Doe", email: "jhondoe@email.com") }

  it "must show user information" do
    visit user_path(user)

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.email)
  end
end
