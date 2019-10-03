# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :dob, :gender, :img_link, :password, :password_confirmation)
  end
end
