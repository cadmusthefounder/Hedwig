# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include UserAuthentication

    identified_by :active_session

    def connect
      if current_session
        self.active_session = current_session
      else
        reject_unauthorized_connection
      end
    end
  end
end
