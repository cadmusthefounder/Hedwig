require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:each) do
    @user = users(:yihang)
  end

  it "email should be present" do
    expect(@user).to be_valid

    @user.email = ""

    expect(@user).not_to be_valid
  end

  it "account_kit_id should be present" do
    expect(@user).to be_valid

    @user.account_kit_id = ""

    expect(@user).not_to be_valid
  end

  it "email should be unique" do
    another_user = User.new(name: "Foo", email: "Bar", account_kit_id: "123")

    expect(another_user).to be_valid

    another_user.email = @user.email

    expect(another_user).not_to be_valid

    another_user.email.upcase!

    expect(another_user).not_to be_valid
  end

  it "account_kit_id should be unique" do
    another_user = User.new(name: "Foo", email: "Bar", account_kit_id: "123")

    expect(another_user).to be_valid

    another_user.account_kit_id = @user.account_kit_id

    expect(another_user).not_to be_valid
  end

  it "user should respond to sessions" do
    expect(@user).to respond_to(:sessions)
  end

  it "should respond to tasks" do
    expect(@user).to respond_to(:tasks)
  end

  it "should respond to interested_tasks" do
    expect(@user).to respond_to(:interested_tasks)
  end

  it "should respond to messages" do
    expect(@user).to respond_to(:messages)
  end

  it "should respond to interests" do
    expect(@user).to respond_to(:interests)
  end

  it "should respond to assigned_tasks" do
    expect(@user).to respond_to(:assigned_tasks)
  end

  it "should respond to credit_purchases" do
    expect(@user).to respond_to(:credit_purchases)
  end
end
