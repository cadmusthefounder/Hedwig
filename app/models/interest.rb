class Interest < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :messages

  scope :accessible_by, ->(user) do
    where(user: user).or(where(task: user.tasks))
  end
end
