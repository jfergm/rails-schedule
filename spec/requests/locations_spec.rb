require 'rails_helper'

RSpec.describe "Locations", type: :request do
  include AuthHelper

  let(:location) do
    create(:location)
  end

  before(:each) do
    sign_in_as(create(:user))
  end
  describe "GET /locations" do
    it "returns http success" do
      get "/locations"
      expect(response).to have_http_status(:success)
    end

    it "renders index template" do
      get "/locations"

      expect(response).to render_template :index
    end
  end

  describe "GET /locations/:id" do
    it "returns http success" do
      get "/locations/#{location.id}"

      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      get "/locations/#{location.id}"

      expect(response).to render_template :show
    end
  end

  describe "GET /locations/new" do
    it "returns http success" do
      get "/locations/new"

      expect(response).to have_http_status(:success)
    end

    it "renders new template" do
      get "/locations/new"

      expect(response).to render_template :new
    end
  end

  describe "GET locations/:id}/edit" do
    it "returns http success" do
      get "/locations/#{location.id}/edit"

      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get "/locations/#{location.id}/edit"

      expect(response).to render_template :edit
    end
  end

  describe "POST /locations" do
    it "create a location with valid form" do
      post "/locations", params: {
        location: {
          name: "Location x",
          address: "St x street 405",
          postal_code: "11111",
          city: "City x",
          state: "State x",
          notes: "notes"
        }
      }

      expect(response).to redirect_to locations_path
      expect(flash[:success]).to eq "Location created"
    end

    it "not create a location with invalid form" do
      post "/locations", params: {
        location: {
          name: nil,
          address: nil,
          postal_code: nil,
          city: nil,
          state: nil,
          notes: nil
        }
      }

      expect(response).to render_template :new
    end
  end

  describe "PATCH /locations/:id" do
    it "update location with valid form" do
      patch "/locations/#{location.id}", params: {
        location: {
          name: "changed name"
        }
      }

      expect(response).to redirect_to locations_path
      expect(flash[:success]).to eq "Location updated"
    end

    it "not update location with invalid form" do
      patch "/locations/#{location.id}", params: {
        location: {
          name: nil
        }
      }

      expect(response).to render_template :edit
    end
  end

  describe "DELETE /locations/:id/" do
    it "should delete a location" do
      delete "/locations/#{location.id}"

      expect(flash[:success]).to eq "Location deleted"
    end
  end
end
