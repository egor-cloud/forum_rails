class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have successfully registered welcome to the forum #{@user.login}"
      redirect_to user_path(@user)
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :password,
                                 :password_confirmation)
  end
end
