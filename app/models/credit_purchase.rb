class CreditPurchase < ApplicationRecord
  belongs_to :user

  enum status: [:pending, :approved]

  validates :amount, presence: true
  validates :status, presence: true

  def status_string
    {
      "pending" => "Pending Approval",
      "approved" => "Approved"
    }[status]
  end
end
