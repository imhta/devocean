class FriendRequestsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      render :show, status: :1
    end
  end
end
