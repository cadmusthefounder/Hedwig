class CreditPurchase < ApplicationRecord
  belongs_to :user

  enum status: [:pending, :approved]

  validates :amount, presence: true
  validates :status, presence: true
end
