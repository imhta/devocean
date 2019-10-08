# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(commentParams)
    if @comment.save
      flash[:success] = 'Comment successfully added'
      redirect_to comments_path(@comment)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @comment.update(commentParams)
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

  def commentParams
    params.require(:comment).permit(:body, :post_id)
  end

  def comment_writer?
    redirect_to root_path unless @comment.user == current_user
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
