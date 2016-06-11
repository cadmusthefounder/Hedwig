require 'rails_helper'

RSpec.describe ThreadsController, :type => :controller do
  describe "create" do
    before(:each) do
      @owner = users(:yihang)
      @user  = users(:other)
      @owner_session = sessions(:yihangs_session)
      @user_session = sessions(:others_session)
      @task  = tasks(:first_task)
    end

    it "should set up the interest object" do
      expect(@task.interested_users).not_to include @user
      cookies[:remember_token] = @user_session.remember_token
      post :create, params: {interest: {task_id: @task.id}}
      @task.reload
      expect(@task.interested_users).to include @user
    end

    it "should not set up the interest object if user is the owner" do
      cookies[:remember_token] = @owner_session.remember_token
      expect { post :create, params: {interest: {task_id: @task.id}} }.not_to change { Interest.count }
    end

    it "should not set up the interest object if user is already interested" do
      @task.interested_users << @user
      cookies[:remember_token] = @user_session.remember_token
      expect { post :create, params: {interest: {task_id: @task.id}} }.not_to change { Interest.count }
    end
  end
end
