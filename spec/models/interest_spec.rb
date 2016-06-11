require 'rails_helper'

RSpec.describe Interest, :type => :model do
  before(:each) do
    @interest = Interest.new
  end

  it "should respond to task" do
    expect(@interest).to respond_to :task
  end

  it "should respond to user" do
    expect(@interest).to respond_to :user
  end

  it "should respond to messages" do
    expect(@interest).to respond_to :messages
  end
end
