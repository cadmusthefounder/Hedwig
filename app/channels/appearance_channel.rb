class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    active_session.update_attributes(online: true)
  end

  def unsubscribed
    active_session.update_attributes(online: false)
  end
end
