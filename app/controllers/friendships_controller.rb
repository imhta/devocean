# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: :destroy
  def index
    @friends = current_user.friends
  end

  def create
    friend_request = current_user.friend_request(User.find(params[:user_id]))
    redirect_back(fallback_location: root_path)
  end

  def update
    return unless current_user.requested_friends.include?(@user)

    current_user.accept(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.remove_friend(@friend)
    head :no_content
  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
