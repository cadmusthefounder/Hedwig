class Transactions::CreditPurchasesController < ApplicationController
  before_action :ensure_logged_in

  def new
    @title = 'Purchase Credit'
    @transaction = current_user.transactions.credit_purchase.build
    render 'transactions/new'
  end

  def create
    @title = 'Purchase Credit'
    @transaction = current_user.transactions.credit_purchase.build(transaction_params)
    if @transaction.save
      @transaction.status = :approved
      @transaction.user.credit += @transaction.amount
      @transaction.save
      @transaction.user.save
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
