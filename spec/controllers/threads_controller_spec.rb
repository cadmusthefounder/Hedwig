require 'rails_helper'

RSpec.describe ThreadsController, :type => :controller do
  describe "show" do
    before(:each) do
      # `user` is interested in `task`, which is created by `owner`.
      # `other_task` is some other task that both `user` and `owner` have sent
      # messages to.
      @owner = users(:yihang)
      @user  = users(:other)
      @task  = tasks(:first_task)
      @other_task = tasks(:second_task)

      @owner_session = sessions(:yihangs_session)
      @user_session  = sessions(:others_session)

      @task.interested_users << @user

      @message1 = @task.messages.create(message: "hello", user: @owner)
      @message2 = @task.messages.create(message: "world", user: @user)

      @message3 = @other_task.messages.create(message: "nope", user: @owner)
      @message4 = @other_task.messages.create(message: "nope", user: @user)
    end

    it "should load the correct messages" do
      cookies[:remember_token] = @owner_session.remember_token
      get :show, params: {task_id: @task.id, id: @user.id}
      messages = assigns(:messages)

      expect(messages.length).to be 2
      expect(messages).to include @message1
      expect(messages).to include @message2
      expect(messages).not_to include @message3
      expect(messages).not_to include @message4
    end

    it "should ensure that only authorized users can see the thread" do
      get :show, params: {task_id: @task.id, id: @user.id}
      expect(response).to redirect_to new_session_path

      charlie = User.create(email: "charlie@example.com", account_kit_id: "charlie")
      charlies_session = charlie.sessions.create
      cookies[:remember_token] = charlies_session.remember_token
      get :show, params: {task_id: @task.id, id: @user.id}
      expect(response).to redirect_to root_path
    end
  end
end
