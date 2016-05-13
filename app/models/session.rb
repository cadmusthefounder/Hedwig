class Session < ApplicationRecord
  validates :remember_token, uniqueness: true

  belongs_to :user

  has_secure_token :remember_token
end
