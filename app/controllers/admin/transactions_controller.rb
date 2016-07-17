class Admin::TransactionsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin

  def index
    @transactions = Transaction.order(created_at: :desc)
  end

  def update
    @transaction = Transaction.find(params[:id])

    return unless @transaction.pending?

    if @transaction.credit_purchase?
      @transaction.status = :approved
      @transaction.user.credit += @transaction.amount
    end

    if @transaction.cash_out_request? && @transaction.user.credit >= @transaction.amount
      @transaction.status = :approved
      @transaction.user.credit -= @transaction.amount
    end

    @transaction.user.save
    @transaction.save

    redirect_to admin_transactions_path
  end
end
