require 'rails_helper'

RSpec.describe "locations/show.html.tailwindcss", type: :view do
  let(:location) do
    Location.create(
      name: "Main location",
      address: "Main st 23",
      postal_code: "00000",
      city: "Main city",
      state: "Main state",
      notes: "Notes..."
    )
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
