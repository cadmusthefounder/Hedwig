class Transactions::CashOutRequestsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @title = 'Request Cash Out'
    @transaction = current_user.transactions.cash_out_request.build
    render 'transactions/new'
  end

  def create
    @title = 'Request Cash Out'
    @transaction = current_user.transactions.cash_out_request.build(transaction_params)

    if current_user.credit < @transaction.amount
      @transaction.errors.add(:amount, :too_high, message: "is higher than your available credit")
      render 'transactions/new'
    elsif @transaction.save
      redirect_to transactions_path
    else
      render 'transactions/new'
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
