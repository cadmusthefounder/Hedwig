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
end
