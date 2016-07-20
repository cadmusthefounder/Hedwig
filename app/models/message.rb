class Message < ApplicationRecord
  belongs_to :user
  belongs_to :interest, touch: :last_sent_at
end
