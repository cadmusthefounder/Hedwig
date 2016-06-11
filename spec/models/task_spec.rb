require 'rails_helper'

RSpec.describe Task, :type => :model do
  it "task should be valid" do
    @first_task = tasks(:first_task)

    expect(@first_task).to be_valid
  end

  it "from address should be present" do
    @first_task = tasks(:first_task)

    expect(@first_task).to be_valid

    @first_task.from_address = ""

    expect(@first_task).not_to be_valid
  end

  it "to address should be present" do
    @first_task = tasks(:first_task)

    expect(@first_task).to be_valid

    @first_task.to_address = ""

    expect(@first_task).not_to be_valid
  end

  it "price should be present" do
    @first_task = tasks(:first_task)

    expect(@first_task).to be_valid

    @first_task.price = ""

    expect(@first_task).not_to be_valid
  end

  it "from postal code should be exactly 6 characters long" do
    @first_task = tasks(:first_task)

    expect(@first_task).to be_valid

    @first_task.from_postal_code = "12"

    expect(@first_task).not_to be_valid

    @first_task.from_postal_code = "1234567"

    expect(@first_task).not_to be_valid
  end

  it "to postal code should be exactly 6 characters long" do
    @first_task = tasks(:first_task)

    expect(@first_task).to be_valid

    @first_task.to_postal_code = "12"

    expect(@first_task).not_to be_valid

    @first_task.to_postal_code = "1234567"

    expect(@first_task).not_to be_valid
  end

  it "should respond to user" do
    expect(Task.new).to respond_to :user
  end
end
