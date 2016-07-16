class Admin::CreditPurchasesController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin

  def all_index
    @title = 'All Purchases'
    @credit_purchases = CreditPurchase.all.includes(:user).order(created_at: :desc)
    render 'index'
  end

  def pending_index
    @title = 'Pending Purchases'
    @credit_purchases = CreditPurchase.pending.includes(:user).order(created_at: :desc)
    render 'index'
  end

  def approved_index
    @title = 'Approved Purchases'
    @credit_purchases = CreditPurchase.approved.includes(:user).order(created_at: :desc)
    render 'index'
  end

  def approve
    @credit_purchase = CreditPurchase.find(params[:id])

    if @credit_purchase.pending?
      @credit_purchase.approve!
    else
      flash[:error] = "Purchase is not pending"
    end

    redirect_to all_admin_credit_purchases_path
  end
end
