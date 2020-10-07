class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update, :show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha(model: @user) && @user.save
      UserMailer.account_activation(@user).deliver_now
      # SendMailToUsersJob.perform_later(@user.id)
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "the data of your account was changed successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :password,
                                 :password_confirmation, :avatar)
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    # binding.pry
    redirect_to(root_url) unless current_user?(@user)
  end

end
