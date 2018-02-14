require 'rails_helper'

RSpec.describe ActivityController, type: :controller do


  describe "GET #mine" do
    user =
      FactoryBot.create(
        :user,
        uid: '5702001256',
        settings: { token: '5702001256.a2164f4.32d510f6063c4367aa2ed85441ab8054' }
      )

    login_user(user)

    before do
      get :mine
    end

    it "returns http success" do
      VCR.use_cassette('instagram/client') do
        expect(response).to have_http_status(:success)
      end

    end

    it "sets album instance variable" do
      VCR.use_cassette('instagram/client') do
        expect(assigns(:album)).to be_truthy
      end
    end
  end

end
