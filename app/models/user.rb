class User < ApplicationRecord
  has_many :tasks
  has_and_belongs_to_many :interested_tasks, class_name: "Task", join_table: :interested_tasks_users

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :account_kit_id, presence: true, uniqueness: true

  has_many :sessions
end
