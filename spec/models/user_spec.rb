require 'rails_helper'

RSpec.describe User, :type => :model do
  fixtures :all

  it "email should be present" do
    @user = users(:yihang)

    expect(@user).to be_valid

    @user.email = ""

    expect(@user).not_to be_valid
  end

  it "account_kit_id should be present" do
    @user = users(:yihang)

    expect(@user).to be_valid

    @user.account_kit_id = ""

    expect(@user).not_to be_valid
  end

  it "email should be unique" do
    @user = users(:yihang)

    another_user = User.new(name: "Foo", email: "Bar", account_kit_id: "123")

    expect(another_user).to be_valid

    another_user.email = @user.email

    expect(another_user).not_to be_valid

    another_user.email.upcase!

    expect(another_user).not_to be_valid
  end

  it "account_kit_id should be unique" do
    @user = users(:yihang)

    another_user = User.new(name: "Foo", email: "Bar", account_kit_id: "123")

    expect(another_user).to be_valid

    another_user.account_kit_id = @user.account_kit_id

    expect(another_user).not_to be_valid
  end

  it "user should respond to sessions" do
    @user = users(:yihang)
    expect(@user).to respond_to(:sessions)
  end
end
