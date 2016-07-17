require 'rails_helper'

RSpec.describe Admin::TransactionsController, :type => :controller do
  before(:each) do
    @admin = users(:admin)
    @admins_session = sessions(:admins_session)
    cookies[:remember_token] = @admins_session.remember_token
  end

  describe "update" do
    it "should approve a pending credit purchase" do
      transaction = transactions(:pending_purchase)

      expect do
        patch :update, params: {id: transaction.id}
      end.to change { transaction.user.reload.credit }.by(transaction.amount)

      expect(transaction.reload).to be_approved
    end

    it "should not re-approve a approved credit purchase" do
      transaction = transactions(:approved_purchase)

      expect do
        patch :update, params: {id: transaction.id}
      end.not_to change { transaction.user.reload.credit }
    end

    it "should approve a pending cash out request if the user has enough credit" do
      transaction = transactions(:pending_cash_out)
      transaction.user.update(credit: transaction.amount + 1)

      expect do
        patch :update, params: {id: transaction.id}
      end.to change { transaction.user.reload.credit }.by(-transaction.amount)
      expect(transaction.reload).to be_approved
    end

    it "should not approve a pending cash out request if the user does not have enough credit" do
      transaction = transactions(:pending_cash_out)
      transaction.user.update(credit: 0)

      expect do
        patch :update, params: {id: transaction.id}
      end.not_to change { transaction.user.reload.credit }
      expect(transaction.reload).to be_pending
    end

    it "should not re-approve a approved cash out request" do
      transaction = transactions(:approved_cash_out)
      transaction.user.update(credit: transaction.amount + 1)

      expect do
        patch :update, params: {id: transaction.id}
      end.not_to change { transaction.user.reload.credit }
    end
  end
end
