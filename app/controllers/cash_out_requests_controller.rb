class CashOutRequestsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @cash_out_request = CashOutRequest.new
  end

  def create
    @cash_out_request = current_user.cash_out_requests.build(cash_out_request_params)

    if current_user.credit < @cash_out_request.amount
      @cash_out_request.errors.add(:amount, :too_high, message: "is higher than your available credit")
      render 'new'
    elsif @cash_out_request.save
      redirect_to transactions_path
    else
      render 'new'
    end
  end

  private

  def cash_out_request_params
    params.require(:cash_out_request).permit(:amount)
  end
end
