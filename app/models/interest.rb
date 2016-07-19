class Interest < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :messages

  scope :accessible_by, ->(user) do
    where(user: user).or(where(task: user.tasks))
  end

  def active?
    task.brand_new? ||
    (task.assigned? && task.assigned_user_id == user_id) ||
    (task.in_progress? && task.assigned_user_id == user_id)
  end
end
