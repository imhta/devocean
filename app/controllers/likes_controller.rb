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
    like = Like.find_by(user_id: params[:like][:user_id], post_id: params[:like][:post_id])
    like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end

  def find_post
    @post = Post.find(params[:like][:post_id])
  end

  def like_owner?
    current_user.id == params[:like][:user_id]
  end

  def already_liked?
    Like.where(user_id: params[:like][:user_id], post_id: params[:like][:post_id]).exists?
  end
end
