class MessagesController < ApplicationController
  before_action :ensure_logged_in
  before_action :extract_interest
  before_action :ensure_authorized

  def index
    # For simplicity, we assume that (a.id <=> b.id) == (a.created_at <=> b.created_at)
    @messages = @interest.messages
    @messages = @messages.where('id < ?', params[:before]) if params[:before]
    @messages = @messages.last(20)
  end

  def create
    @message = @interest.messages.create(message: message_params[:message], user: current_user)

    # TODO error handling
    ChatChannel.broadcast_to(@interest, {id: @message.id, message: @message.message, sender: current_user.name})
  end


  private

  def extract_interest
    @interest = Interest.find(params[:thread_id])
  end

  def ensure_authorized
    redirect_to root_path unless @interest.task.user == current_user || @interest.user == current_user
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
