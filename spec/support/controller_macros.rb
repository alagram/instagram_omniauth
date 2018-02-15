module ControllerMacros
  def login_user(a_user=nil)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = a_user || FactoryBot.create(:user)
      sign_in @user
    end
  end
end
