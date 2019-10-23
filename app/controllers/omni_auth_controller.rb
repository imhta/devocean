# frozen_string_literal: true

class OmniAuthController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if (user = User.find_by(email: @user.email))
      @user = user
    end
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end
