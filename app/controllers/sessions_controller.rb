# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || home_index_path
  end
end
