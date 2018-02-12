require 'rails_helper'

RSpec.describe ActivityController, type: :controller do

  describe "GET #mine" do
    it "returns http success" do
      get :mine
      expect(response).to have_http_status(:success)
    end
  end

end
