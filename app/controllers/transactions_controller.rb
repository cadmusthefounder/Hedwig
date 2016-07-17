class TransactionsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @credit_purchases = current_user.credit_purchases
    @cash_out_requests = current_user.cash_out_requests
    @transactions = (@credit_purchases + @cash_out_requests).sort { |a, b| -(a.created_at <=> b.created_at) }
  end
end
