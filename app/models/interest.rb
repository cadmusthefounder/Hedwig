class Interest < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :messages
end
