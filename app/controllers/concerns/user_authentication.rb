module UserAuthentication
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= current_session&.user
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

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
