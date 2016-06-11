require 'rails_helper'

RSpec.describe Task, :type => :model do
  before(:each) do
    @first_task = tasks(:first_task)
  end

  it "from address should be present" do
    expect(@first_task).to be_valid

    @first_task.from_address = ""

    expect(@first_task).not_to be_valid
  end

  it "to address should be present" do
    expect(@first_task).to be_valid

    @first_task.to_address = ""

    expect(@first_task).not_to be_valid
  end

  it "price should be present" do
    expect(@first_task).to be_valid

    @first_task.price = ""

    expect(@first_task).not_to be_valid
  end

  it "from postal code should be exactly 6 characters long" do
    expect(@first_task).to be_valid

    @first_task.from_postal_code = "12"

    expect(@first_task).not_to be_valid

    @first_task.from_postal_code = "1234567"

    expect(@first_task).not_to be_valid
  end

  it "to postal code should be exactly 6 characters long" do
    expect(@first_task).to be_valid

    @first_task.to_postal_code = "12"

    expect(@first_task).not_to be_valid

    @first_task.to_postal_code = "1234567"

    expect(@first_task).not_to be_valid
  end

  it "should respond to user" do
    expect(@first_task).to respond_to :user
  end

  it "should respond to interested_users" do
    expect(@first_task).to respond_to :interested_users
  end

  it "should respond to messages" do
    expect(@first_task).to respond_to :messages
  end

  it "should respond to interests" do
    expect(@first_task).to respond_to :interests
  end
end
