require 'rails_helper'

RSpec.describe "Home", type: :request do
  include AuthHelper

  describe "GET /index" do
    it "returns http success" do
      sign_in_as(create(:user))
      get "/"

      expect(response).to have_http_status(:success)
    end
  end
end
