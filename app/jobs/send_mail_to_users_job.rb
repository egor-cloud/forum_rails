class SendMailToUsersJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find_by(id: user_id)
    UserMailer.account_activation(@user).deliver_later
  end
end
