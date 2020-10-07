class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    # binding.pry
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url
  end

end
