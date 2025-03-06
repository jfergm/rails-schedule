require 'rails_helper'

RSpec.describe "Clients", type: :request do
  include AuthHelper

  let(:client) { create(:client) }

  before(:each) do
    sign_in_as(create(:user))
  end

  describe "GET /clients" do
    it "returns http success" do
      get "/clients"

      expect(response).to have_http_status(:success)
    end

    it "render index template" do
      get "/clients" do
        expect(response).to render_template :index
      end
    end
  end

  describe "GET /clients/:id" do
    it "returns http success" do
      get "/clients/#{client.id}"

      expect(response).to have_http_status(:success)
    end

    it "render show template" do
      get "/clients/#{client.id}"

      expect(response).to render_template :show
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/clients/new"

      expect(response).to have_http_status(:success)
    end

    it "render new template" do
      get "/clients/new"

      expect(response).to render_template :new
    end
  end

  describe "GET /clients/:id/edit" do
    it "returns http success" do
      get "/clients/#{client.id}/edit"

      expect(response).to have_http_status(:success)
    end

    it "render edit template" do
      get "/clients/#{client.id}/edit"

      expect(response).to render_template :edit
    end
  end

  describe "POST /clients" do
    it "create a client with valid form" do
      post "/clients", params: { client: { name: "Jhon", last_name: "Doe", email: "client@domain.com", phone_number: "1234567890" } }

      expect(response).to redirect_to clients_path
      expect(flash[:success]).to eq 'Client created'
    end

    it "not create a client with invalid form" do
      post "/clients", params: { client: { name: nil, email: nil } }

      expect(response).to render_template :new
    end
  end

  describe "PATCH /clients/:id" do
    it "update a client with valid form" do
      patch "/clients/#{client.id}/", params: { client: { name: "Other name" } }

      expect(response).to redirect_to clients_path
      expect(flash[:success]).to eq "Client updated"
    end

    it "not update a client with invalid form" do
      patch "/clients/#{client.id}/", params: { client: { email: nil } }

      expect(response).to render_template :edit
    end
  end

  describe "DELETE /clients/:id" do
    it "should update a client" do
      delete "/clients/#{client.id}"

      expect(response).to redirect_to clients_path
      expect(flash[:success]).to eq 'Client deleted'
    end
  end
end
