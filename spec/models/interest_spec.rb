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
end
