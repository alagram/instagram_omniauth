require 'rails_helper'

RSpec.describe ActivityController, type: :controller do

  user =
    FactoryBot.create(
      :user,
      uid: '5702001256',
      settings: { token: '7097534881.a2164f4.a0cc5a573ba347f097f9745b59c7cc09' }
    )

  login_user(user)

  describe "GET #mine" do
    before do
      get :mine
    end

    it "returns http success", :vcr do
      expect(response).to have_http_status(:success)
    end

    it "sets album instance variable", :vcr do
      expect(assigns(:album)).to be_truthy
    end
  end

end
