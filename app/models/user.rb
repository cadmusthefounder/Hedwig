class User < ApplicationRecord
  has_many :tasks
  has_many :messages
  has_many :interests
  has_many :interested_tasks, through: :interests, source: :task

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :account_kit_id, presence: true, uniqueness: true

  has_many :sessions
end
