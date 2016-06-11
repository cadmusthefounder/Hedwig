class ThreadsController < ApplicationController
  before_action :ensure_logged_in
  before_action :extract_task
  before_action :extract_user
  before_action :ensure_authorized

  def show
    # TODO lazy load the messages
    @messages = @task.messages.where(user: [@user, @task.user]).order(:created_at)
  end

  def create_message
    @message = Message.create(message: message_params[:message], user: current_user, task: @task)

    # TODO error handling
    redirect_to task_thread_path(@task, @user)
  end

  private

  def extract_task
    @task = Task.find(params[:task_id])
  end

  def extract_user
    @user = @task.interested_users.find(params[:id])
  end

  def ensure_authorized
    redirect_to root_path unless @task.user == current_user || @user == current_user
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
