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

  it "should respond to transactions" do
    expect(@user).to respond_to(:transactions)
  end

  it 'should respond to average_rating' do
    expect(@user).to respond_to(:average_rating)
  end

  describe 'average rating' do
    before(:each) do
      @user.reviews.each(&:destroy)
    end

    it 'should be nil when there is no review' do
      expect(@user.reviews.count).to eq 0
      expect(@user.average_rating).to be_nil
    end

    it 'should be the average rating among all reviews' do
      owner = users(:other)
      @user.reviews.create!(comment: '1', rating: 1, owner: owner)
      expect(@user.average_rating).to eq 1
      @user.reviews.create!(comment: '3', rating: 3, owner: owner)
      expect(@user.average_rating).to eq 2
      @user.reviews.create!(comment: '5', rating: 5, owner: owner)
      expect(@user.average_rating).to eq 3
    end
  end
end
