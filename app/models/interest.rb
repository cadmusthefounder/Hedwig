class Interest < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :messages

  scope :accessible_by, ->(user) do
    where(user: user).or(where(task: user.tasks))
  end

  scope :active, -> do
    interests = joins(:task)
    interests_assigned_to = interests.where('interests.user_id = tasks.assigned_user_id')

    brand_new   = interests.where(task: Task.brand_new)
    assigned    = interests_assigned_to.where(task: Task.assigned)
    in_progress = interests_assigned_to.where(task: Task.in_progress)

    brand_new.or(assigned).or(in_progress)
  end

  def active?
    task.brand_new? ||
    (task.assigned? && task.assigned_user_id == user_id) ||
    (task.in_progress? && task.assigned_user_id == user_id)
  end
end
