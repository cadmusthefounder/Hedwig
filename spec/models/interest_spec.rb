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

  it "should respond to active?" do
    expect(@interest).to respond_to(:active?)
  end

  describe "accessible_by" do
    it "should return all interests accessible by the specified user" do
      user = users(:yihang)
      second_task = tasks(:second_task)
      user.interested_tasks << second_task
      user.reload
      expect(user.interested_tasks).to include second_task

      accessible_interests = Interest.accessible_by(user)
      user_tasks = user.tasks.includes(:interests)
      user_tasks_interests_count = user.tasks.map(&:interests).map(&:length).reduce(&:+)
      expect(accessible_interests.length).to eq (user_tasks_interests_count + user.interests.length)

      user.interests.each do |interest|
        expect(accessible_interests).to include interest
      end

      user.tasks.each do |task|
        task.interests.each do |interest|
          expect(accessible_interests).to include interest
        end
      end
    end
  end

  describe "active?" do
    before(:each) do
      @user = users(:other)
    end

    it "should be true for brand_new task" do
      brand_new_task = tasks(:brand_new_task)
      interest = brand_new_task.interests.create!(user: @user)
      expect(interest).to be_active
      expect(Interest.active).to include(interest)
    end

    it "should be true for assigned task if the user is the same as the assigned user" do
      assigned_task = tasks(:assigned_task)
      assigned_task.update!(assigned_user: @user)
      interest = assigned_task.interests.create!(user: @user)
      expect(interest).to be_active
      expect(Interest.active).to include(interest)
    end

    it "should be false for assigned task if the user is not the same as the assigned user" do
      assigned_task = tasks(:assigned_task)
      assigned_task.update!(assigned_user_id: @user.id + 1)
      interest = assigned_task.interests.create!(user: @user)
      expect(interest).not_to be_active
      expect(Interest.active).not_to include(interest)
    end

    it "should be true for in_progress task if the user is the same as the assigned user" do
      in_progress_task = tasks(:in_progress_task)
      in_progress_task.update!(assigned_user: @user)
      interest = in_progress_task.interests.create!(user: @user)
      expect(interest).to be_active
      expect(Interest.active).to include(interest)
    end

    it "should be false for in_progress task if the user is not the same as the assigned user" do
      in_progress_task = tasks(:in_progress_task)
      in_progress_task.update!(assigned_user_id: @user.id + 1)
      interest = in_progress_task.interests.create!(user: @user)
      expect(interest).not_to be_active
      expect(Interest.active).not_to include(interest)
    end

    it "should be false for completed task" do
      completed_task = tasks(:completed_task)
      completed_task.update!(assigned_user: @user)
      interest = completed_task.interests.create!(user: @user)
      expect(interest).not_to be_active
      expect(Interest.active).not_to include(interest)
      completed_task.update!(assigned_user_id: @user.id + 1)
      expect(interest).not_to be_active
      expect(Interest.active).not_to include(interest)
    end
  end
end
