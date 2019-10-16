# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @users = current_user.requested_friends
  end
end
