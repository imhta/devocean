# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end
end
