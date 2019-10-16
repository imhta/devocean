# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
  end

  def create
    friend_request = current_user.friend_request(User.find(params[:user_id]))
    redirect_back(fallback_location: root_path)
  end

  def update
    return unless current_user.requested_friends.include?(get_user_from_params)

    current_user.accept(get_user_from_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.friends.destroy(set_friend_from_params)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friend_from_params
    current_user.friends.find(params[:id])
  end

  def get_user_from_params
    User.find(params[:id])
  end
end
