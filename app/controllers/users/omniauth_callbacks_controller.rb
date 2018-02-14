class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram
    @auth_hash = request.env['omniauth.auth']

    if successful_integration_creation
      sign_in(@user, scope: @user)
      redirect_to root_path, notice: 'Signed in successfully.'
    else
      redirect_to user_session_path, alert: 'Instagram was unable to authorize this request. Please try again.'
    end
  end

  private

  def create_user
    @user = User.find_or_create_from_auth_hash(@auth_hash)
  end

  def successful_integration_creation
    @auth_hash != :invalid_credentials &&
                  @auth_hash&.credentials&.token &&
                  create_user
  end
end
