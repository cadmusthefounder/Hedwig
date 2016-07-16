require 'rails_helper'

RSpec.describe CreditPurchase, type: :model do
  before(:each) do
    @credit_purchase = credit_purchases(:yihangs_purchase)
  end

  it "should be valid" do
    expect(@credit_purchase).to be_valid
  end

  describe "validations" do
    it "amount should be present" do
      @credit_purchase.amount = nil
      expect(@credit_purchase).not_to be_valid
    end

    it "status should be present" do
      @credit_purchase.status = nil
      expect(@credit_purchase).not_to be_valid
    end
  end

  describe "associations" do
    it "should belong to user" do
      expect(@credit_purchase).to respond_to(:user)
    end
  end
end
