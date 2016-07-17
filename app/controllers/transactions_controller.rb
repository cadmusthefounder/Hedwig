class TransactionsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @transactions = current_user.transactions.order(created_at: :desc)
  end
end
