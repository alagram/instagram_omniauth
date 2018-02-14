require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  describe "GET #instagram" do

    before do
      OmniAuth.config.test_mode = true
    end

    it "passes auth and returns http redirect" do
      OmniAuth.config.add_mock(:instagram, {uid: '987654', credentials: {token: '12345'}})
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram]

      get :instagram
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eq 'Signed in successfully.'
    end

    it "fails auth and returns http redirect" do
      OmniAuth.config.mock_auth[:instagram] = :invalid_credentials
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram]

      get :instagram
      expect(response).to have_http_status(:redirect)
      expect(flash[:alert]).to eq "Instagram was unable to authorize this request. Please try again."
    end
  end
end
