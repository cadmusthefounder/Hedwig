class SessionsController < ApplicationController
  # POST /sessions
  # POST /sessions.json
  def create
    access_token = AccountKit.access_token(params[:code])
    me = AccountKit.me(access_token)
    email = me["email"]["address"]
    account_kit_id = me["id"]

    @user = User.find_by(account_kit_id: account_kit_id)
    unless @user
      @user = User.create(email: email, account_kit_id: account_kit_id)
    end

    @session = @user.sessions.create

    cookies[:remember_token] = @session.remember_token

    # TODO redirect to feed for existing user

    redirect_to update_profile_path if @user.name.nil?
  end

  # DELETE /sessions
  # DELETE /sessions
  def destroy
    current_session.destroy if current_session

    cookies.delete(:remember_token)
    @current_user = nil

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:user_id, :remember_token)
    end
end
