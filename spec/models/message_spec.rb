require 'rails_helper'

RSpec.describe Message, :type => :model do
  before(:each) do
    @message = Message.new
  end

  it "should respond to user" do
    expect(@message).to respond_to :user
  end

  it "should respond to interest" do
    expect(@message).to respond_to :interest
  end
end
