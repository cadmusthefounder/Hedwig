class Transaction < ActiveRecord::Base
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }

  enum status: [:pending, :approved]
  enum transaction_type: [:credit_purchase, :cash_out_request]

  def status_string
    {
      "pending" => "Pending Approval",
      "approved" => "Approved"
    }[status]
  end

  def transaction_type_string
    {
      "credit_purchase" => "Credit Purchase",
      "cash_out_request" => "Cash Out"
    }[transaction_type]
  end
end
