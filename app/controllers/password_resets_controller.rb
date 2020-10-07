class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    #password_reset - это ключ отправляемый с формы password_resets/new
    unless @user = User.find_by(email: params[:password_reset][:email])
      flash.now[:danger] = "email not found"
      render 'new'
    else
      #Если такой пользователь найден создать дайджест в базе на основе токена и выслать на почту этот виртуальный
      # токен. Виртуальные атрибуты кешируются в памяти и к ним можно обращаться на момент сеанса
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      # ResetPasswordToUsersJob.perform_later(@user.id)
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    end
  end

  def edit
    #касячек
  end

  def update
    if password_blank?
      flash.now[:danger] = "Password can't be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Возвращает true, если пароль пустой.
  def password_blank?
    params[:user][:password].blank?
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Подтверждает допустимость пользователя.
  def valid_user
    unless (@user && @user.activated? &&
      @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

end
