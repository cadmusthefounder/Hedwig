class MessagesController < ApplicationController
  before_action :ensure_logged_in
  before_action :extract_interest
  before_action :ensure_authorized

  layout "layouts/application_chat", only: :index

  def index
    # For simplicity, we assume that (a.id <=> b.id) == (a.created_at <=> b.created_at)
    @messages = @interest.messages
    @messages = @messages.where('id < ?', params[:before]) if params[:before]
    @messages = @messages.last(20)
  end

  def create
    @message = @interest.messages.create(message: message_params[:message], user: current_user)

    if @interest.user == current_user
      @interest.update(read_by_owner: false)
      ThreadChannel.broadcast_to(@interest.task.user, action: "mark_as_unread", id: @interest.id)
    else
      @interest.update(read_by_user: false)
      ThreadChannel.broadcast_to(@interest.user, action: "mark_as_unread", id: @interest.id)
    end

    # TODO error handling
    ChatChannel.broadcast_to(@interest.user, @message)
    ChatChannel.broadcast_to(@interest.task.user, @message)
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
