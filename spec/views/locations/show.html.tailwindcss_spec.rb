require 'rails_helper'

RSpec.describe "locations/show.html.tailwindcss", type: :view do
  include AuthHelper

  let(:location) { create(:location) }
  before(:each) do
    sign_in_as(create(:user))
  end
  it "shows location info" do
    visit location_path(location)

    expect(page).to have_content location.name
    expect(page).to have_content location.address
    expect(page).to have_content location.postal_code
    expect(page).to have_content location.city
    expect(page).to have_content location.notes
  end
end
