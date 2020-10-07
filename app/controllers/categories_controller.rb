class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = Post.posts_to_category_and_users(@category.id).paginate(:page => params[:page])
  end

  def index
    @categories = Category.all
  end
end
