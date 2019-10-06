# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :dob, :gender,
                                 :password, :password_confirmation)
  end

  private

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || home_index_path
  end
end
