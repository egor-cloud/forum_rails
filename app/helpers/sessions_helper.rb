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
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  #Если пользователь не аутенфицирован он может начать редактировать себя что неприемлимо
  def logged_in_user
    if !logged_in?
      store_location
      flash[:danger] = "Pls authenticate"
      redirect_to login_url
    end
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

  def current_user?(user)
    user == current_user
  end

  # Перенаправить по сохраненному адресу или на страницу по умолчанию.
  def redirect_back_or(user)
    if user.admin?
      flash[:success] = "Hello admin"
    else
      flash[:success] = "Hello #{user.login}"
    end
    redirect_to(session[:save_url] || user)
    session.delete(:save_url)
  end

  # Запоминает URL.
  def store_location
    session[:save_url] = request.url if request.get?
  end

  def admin_user
    unless logged_in? && current_user.admin == true
      redirect_to(root_url)
    end
  end

end

