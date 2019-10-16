# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all - [current_user] - current_user.friends
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end
end
