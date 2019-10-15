# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.desc
  end

  def create
    post = current_user.posts.new(post_params)
    if post.save!
      redirect_back(fallback_location: root_path)
    else
      flash['alert'] = 'Error occurred'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
