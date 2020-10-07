class ResetPasswordToUsersJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)
    UserMailer.password_reset(@user).deliver_later
  end
end
