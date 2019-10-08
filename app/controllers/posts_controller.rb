# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    post = current_user.posts.new(post_params)
    if post.save!
      redirect_back(fallback_location: root_path)
    else
      flash['alert'] = 'Error occurred'
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
