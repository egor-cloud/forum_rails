class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = Tag.users_and_their_posts.find(params[:id]).posts.order(created_at: :desc).paginate(:page => params[:page])
  end
end
