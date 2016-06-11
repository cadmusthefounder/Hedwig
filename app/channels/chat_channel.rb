class ChatChannel < ApplicationCable::Channel
  def subscribed
    # TODO auth
    interest = Interest.find(params[:thread_id])
    stream_for interest
  end
end
