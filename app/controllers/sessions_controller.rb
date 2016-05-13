class SessionsController < ApplicationController
  before_action :set_session, only: :destroy

  # GET /sessions/new
  def new
    @session = Session.new
  end

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

    # TODO redirect to feed instead
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:user_id, :remember_token)
    end
end
