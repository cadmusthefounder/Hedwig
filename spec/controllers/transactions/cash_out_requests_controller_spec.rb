require 'rails_helper'

RSpec.describe Transactions::CashOutRequestsController, :type => :controller do
  before(:each) do
    @user = users(:yihang)
    @yihangs_session = sessions(:yihangs_session)
    cookies[:remember_token] = @yihangs_session.remember_token
  end

  describe "create" do
    it "should post create with success if user has enough credit" do
      expect(@user.credit).to be > 1
      expect do
        post :create, params: { transaction: {amount: 1} }
      end.to change { @user.transactions.cash_out_request.count }.by 1
      expect(response).to redirect_to(transactions_path)
    end

    it "should post create with error if user does not have enough credit" do
      expect do
        post :create, params: { transaction: {amount: @user.credit + 1} }
      end.not_to change { @user.transactions.cash_out_request.count }
      expect(response).to render_template "transactions/new"
    end
  end
end
