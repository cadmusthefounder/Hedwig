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

  def approve!
    return unless pending?

    self.status = :approved
    self.save

    user.credit += amount
    user.save
  end
end
