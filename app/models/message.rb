class Message < ApplicationRecord
  belongs_to :user
  belongs_to :interest, touch: true
end
