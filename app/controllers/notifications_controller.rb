# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = current_user.requested_friends
  end
end
