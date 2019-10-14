# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.create(comment_params)
    if comment.save!
      redirect_back(fallback_location: root_path)
    else
      flash['alert'] = 'Error occurred'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment successfully updated'
      redirect_to comments_path(@comment)
    else
      render :edit
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment.destroy
    flash[:notice] = 'Comment was deleted'
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end

  def comment_writer?
    redirect_to root_path unless @comment.user == current_user
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
