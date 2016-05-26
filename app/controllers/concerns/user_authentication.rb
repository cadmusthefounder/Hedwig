module UserAuthentication
  extend ActiveSupport::Concern

  def current_user
    if cookies[:remember_token] && !@current_user
      session = Session.find_by(remember_token: cookies[:remember_token])
      @current_user = session.user if session
    end

    @current_user
  end

  def current_session
    if cookies[:remember_token] && !@current_session
      @current_sesion = Session.find_by(remember_token: cookies[:remember_token])
    end

    @current_sesion
  end

  def logged_in?
    !current_user.nil?
  end

  def ensure_logged_in
    redirect_to new_session_path unless logged_in?
  end
end
