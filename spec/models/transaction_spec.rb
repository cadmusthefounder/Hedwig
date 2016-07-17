require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:each) do
    @transaction = Transaction.new
  end

  describe "associations" do
    it "belongs to user" do
      expect(@transaction).to respond_to(:user)
    end
  end

  describe "validations" do
    before(:each) do
      @transaction = transactions(:pending_purchase)
    end

    it "fixture object should be valid" do
      expect(@transaction).to be_valid
    end

    it "amount should be positive" do
      @transaction.amount = -5
      expect(@transaction).not_to be_valid
      @transaction.amount = 0
      expect(@transaction).not_to be_valid
    end
  end

  describe "status_string" do
    it "should respond to status_string" do
      expect(@transaction).to respond_to(:status_string)
    end

    it "should be 'Pending Approval' when status is :pending" do
      @transaction.status = :pending
      expect(@transaction.status_string).to eq "Pending Approval"
    end

    it "should be 'Approved' when status is :approved" do
      @transaction.status = :approved
      expect(@transaction.status_string).to eq "Approved"
    end
  end

  describe "transaction_type_string" do
    it "should respond to transaction_type_string" do
      expect(@transaction).to respond_to(:transaction_type_string)
    end

    it "should return 'Credit Purchase' when transaction_type is :credit_purchase" do
      @transaction.transaction_type = :credit_purchase
      expect(@transaction.transaction_type_string).to eq "Credit Purchase"
    end

    it "should return 'Cash Out' when transaction_type is :cash_out_request" do
      @transaction.transaction_type = :cash_out_request
      expect(@transaction.transaction_type_string).to eq "Cash Out"
    end
  end
end
