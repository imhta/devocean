# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save!
      redirect_back(fallback_location: root_path)
    else
      flash['alert'] = 'Error occurred'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
