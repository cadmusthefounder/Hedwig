class User < ApplicationRecord
  has_and_belongs_to_many :tasks
  has_many :owned, :class_name => "Task", :foreign_key => "owner_id"

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :account_kit_id, presence: true, uniqueness: true

  has_many :sessions
end
