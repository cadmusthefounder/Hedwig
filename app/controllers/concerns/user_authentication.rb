module UserAuthentication
  extend ActiveSupport::Concern

  def current_user
    if cookies[:remember_token] && !@current_user
      session = Session.find_by(remember_token: cookies[:remember_token])
      @current_user = session.user if session
    end

    @current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def ensure_logged_in
    redirect_to new_session_path unless logged_in?
  end
end
