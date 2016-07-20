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

  it "should touch last_sent_at of the associated interest object" do
    user = users(:yihang)
    courier = users(:other)
    task = tasks(:first_task)
    interest = task.interests.create!(user: courier, last_sent_at: 20.years.ago)
    message = interest.messages.create!(user: courier, message: ":)")
    expect(interest.last_sent_at).to be > 10.years.ago
  end
end
