class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @answer = Answer.find(params[:comment][:answer_id])
    respond_to do |format|
      if @comment.save
        format.html do
          flash[:success] = "comment has been successfully saved"
          # redirect_to category_post_path(params[:comment][:category_id], params[:comment][:id])
        end
        format.js
      else
        format.html do
          flash[:success] = "sorry for some reason the comment was not saved"
        end
      end
    end
  end

  def create_children_comment
    @comment = Comment.new(comment_children_params)
    respond_to do |format|
      if @comment.save
        format.html do
          flash[:success] = "comment has been successfully saved"
        end
        format.js
      else
        format.html do
          flash[:success] = "sorry for some reason the comment was not saved"
        end
      end
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :answer_id)
  end

  def comment_children_params
    params.require(:comment).permit(:body, :user_id, :parent_id, :answer_id)
  end

end
