require 'rails_helper'

RSpec.describe CashOutRequest, type: :model do
  before(:each) do
    @cash_out_request = CashOutRequest.new
  end

  describe "associations" do
    it "belongs to user" do
      expect(@cash_out_request).to respond_to(:user)
    end
  end
end
