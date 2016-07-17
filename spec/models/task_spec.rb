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

  it "completion_token should be present" do
    expect(@first_task).to be_valid

    @first_task.completion_token = ""

    expect(@first_task).not_to be_valid
  end

  it "should have a default completion token" do
    task = Task.new
    expect(task.completion_token).not_to be_empty
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

  it "should respond to assigned_user" do
    expect(@first_task).to respond_to :assigned_user
  end

  describe "default values" do
    it "should be 0 for price" do
      expect(Task.new.price).to eq 0
    end
  end

  describe "brand new tasks" do
    it "should return true for brand_new? and false for assigned?, in_progress?, completed?" do
      task = tasks(:brand_new_task)
      expect(task).to be_brand_new
      expect(task).not_to be_assigned
      expect(task).not_to be_in_progress
      expect(task).not_to be_completed
    end
  end

  describe "assigned tasks" do
    it "should return true for assigned? and false for brand_new?, in_progress?, completed?" do
      task = tasks(:assigned_task)
      expect(task).not_to be_brand_new
      expect(task).to be_assigned
      expect(task).not_to be_in_progress
      expect(task).not_to be_completed
    end
  end

  describe "in progress tasks" do
    it "should return true for assigned? and false for brand_new?, in_progress?, completed?" do
      task = tasks(:in_progress_task)
      expect(task).not_to be_brand_new
      expect(task).not_to be_assigned
      expect(task).to be_in_progress
      expect(task).not_to be_completed
    end
  end

  describe "completed tasks" do
    it "should return true for assigned? and false for brand_new?, in_progress?, completed?" do
      task = tasks(:completed_task)
      expect(task).not_to be_brand_new
      expect(task).not_to be_assigned
      expect(task).not_to be_in_progress
      expect(task).to be_completed
    end
  end
end
