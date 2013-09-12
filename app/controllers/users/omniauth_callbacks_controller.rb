class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    handle_oauth("Facebook")
  end

  def twitter
    handle_oauth("Twitter")
  end

  private
  def handle_oauth(provider)
    @user = User.find_or_create_from_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => provider) if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end
end
