class CreditPurchasesController < ApplicationController
  before_action :ensure_logged_in

  def new
    @credit_purchase = CreditPurchase.new
  end

  def create
    @credit_purchase = current_user.credit_purchases.create(credit_purchase_params)

    if @credit_purchase.save
      render 'show'
    else
      render 'new'
    end
  end

  private

  def credit_purchase_params
    params.require(:credit_purchase).permit(:amount)
  end
end
