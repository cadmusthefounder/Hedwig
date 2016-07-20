class ThreadChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def mark_as_read(data)
    thread_id = data["id"]
    interest = Interest.find(thread_id)

    if interest.user == current_user
      interest.update(read_by_user: true)
    else
      interest.update(read_by_owner: true)
    end

    ThreadChannel.broadcast_to(current_user, data)
  end
end
