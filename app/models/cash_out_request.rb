class CashOutRequest < ApplicationRecord
  belongs_to :user

  enum status: [:pending, :approved]

  def status_string
    {
      "pending" => "Pending Approval",
      "approved" => "Approved"
    }[status]
  end

  def type
    "Cash Out"
  end
end
