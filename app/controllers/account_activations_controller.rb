class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    #тк токен при передаче по именнованному url мы поставили вместо id, то в хеше мы обращаемся к нему как к params[:id]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
