# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
  end

  def create
    current_user.friend_request(User.find(params[:user_id]))
    redirect_back(fallback_location: root_path)
  end

  def update
    return unless current_user.requested_friends.include?(user_from_params)

    current_user.accept(user_from_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.friends.destroy(friend_from_params)
    redirect_back(fallback_location: root_path)
  end

  # def mutual_friends
  #   self.class.where({user_id: friend_id, friend_id: user_id})
  # end

  private

  def friend_from_params
    current_user.friends.find(params[:id])
  end

  def user_from_params
    User.find(params[:id])
  end
end
