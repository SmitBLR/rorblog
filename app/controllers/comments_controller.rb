class CommentsController < ApplicationController
  load_and_authorize_resource

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build params[:comment]
    @comment.user = current_user
    @comment.save
  end

  def update
    article = Article.find(params[:article_id])
    @comment = article.comments.find(params[:id])
    @comment.update_attributes(params[:comment])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
