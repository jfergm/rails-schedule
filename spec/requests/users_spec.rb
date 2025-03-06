require 'rails_helper'

RSpec.describe "Users", type: :request do
  include AuthHelper

  let(:user) { create(:user) }

  before(:each) do
    sign_in_as(user)
  end
  describe "GET /users" do
    it "returns http success" do
      get "/users"

      expect(response).to have_http_status(:success)
    end
    it "returns template" do
      get "/users"

      expect(response).to render_template :index
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/users/#{user.id}"

      expect(response).to have_http_status(:success)
    end
    it "returns users/index template" do
      get "/users/#{user.id}"

      expect(response).to render_template :show
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/users/new"

      expect(response).to have_http_status(:success)
    end
    it "returns users/index template" do
      get "/users/new"

      expect(response).to render_template :new
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/users/#{user.id}/edit"

      expect(response).to have_http_status(:success)
    end
    it "returns users/index template" do
      get "/users/#{user.id}/edit"

      expect(response).to render_template :edit
    end
  end

  describe "POST /users" do
    it "should create a user" do
      post '/users', params: { user: { name: "Jhon", last_name: "Doe", email: "email@domain.com", password: "12345avxc" } }

      expect(response).to redirect_to users_path
      expect(flash[:success]).to eq 'User created'
    end

    it "should not create a user" do
      post '/users', params: { user: { name: nil, email: nil } }

      expect(response).to render_template :new
    end
  end

  describe "PATCH /user" do
    it "should update a user" do
      put "/users/#{user.id}", params: { user: { "name": "Nohj" } }

      expect(flash[:success]).to eq 'User updated'
      expect(response).to redirect_to users_path
    end
    it "should not update a user" do
      put "/users/#{user.id}", params: { user: { "email": nil } }

      expect(response).to render_template :edit
    end
  end

  describe "Delete /user" do
    it "should update a user" do
      delete "/users/#{user.id}"

      expect(response).to redirect_to users_path
      expect(flash[:success]).to eq 'User deleted'
    end
  end
end
