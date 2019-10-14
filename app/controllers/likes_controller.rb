# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    return destroy if already_liked?

    like = Like.new(like_params)
    like.save
    flash[:notice] = 'Post liked'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.find_by(like_params)
    like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end

  def already_liked?
    Like.where(like_params).exists?
  end
end
