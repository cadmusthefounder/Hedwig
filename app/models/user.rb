class User < ApplicationRecord
  has_and_belongs_to_many :tasks

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :account_kit_id, presence: true, uniqueness: true

  has_many :sessions
end
