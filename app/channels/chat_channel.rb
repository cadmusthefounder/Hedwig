class ChatChannel < ApplicationCable::Channel
  def subscribed
    interest = Interest.find(params[:thread_id])

    if interest.user == current_user || interest.task.user == current_user
      stream_for interest
    else
      reject
    end
  end
end
