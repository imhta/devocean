# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = Like.new(like_params)
    like.save
    flash[:notice] = 'Post liked'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like.destroy if like_owner? && user_signed_in?
    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def like_owner?
    current_user == @like.user
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end
