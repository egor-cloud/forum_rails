module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    #создать рандомную строку и записать ее дайджест в базу
    user.remember
    #Создать куку на основе id пользователя
    cookies.signed[:user_id] = { value: user.id, expires: 1.week }
    #Создать куку на основе виртуального атрибута remember_token
    cookies[:remember_token] = { value: user.remember_token, expires: 1.week }
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end



end
