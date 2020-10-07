class Admin::CategoriesController < ApplicationController
  before_action :admin_user

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Theme created successfully"
    else
      flash[:danger] = "Failed to create theme"
    end
    redirect_to admin_categories_admin_path
  end

  def edit
    @category = Category.find_by(id: params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Theme update successfully"
    else
      flash[:danger] = "Failed to update theme"
    end
    redirect_to admin_categories_admin_path
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Topic deleted"
    redirect_to admin_categories_admin_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :avatar, :parent_id)
  end

end
