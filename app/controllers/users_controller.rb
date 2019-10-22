# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all - [current_user] - current_user.friends
  end

  def show
    @user= User.find(params[:id])
    # @friend = Friendships.where(user_id: current_user.friend_id)
    @count=0
    @users= current_user.strangers  
    if @users.friend_id == current_user.friend_id
      count+=1
    end

  end
end
