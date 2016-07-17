class ThreadsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @task = Task.find(interest_params[:task_id])

    if @task.user == current_user
      flash[:warning] = "You cannot take up your own request"
    elsif current_user.interested_tasks.include?(@task)
      flash[:warning] = "You have already expressed interest"
    else
      current_user.interested_tasks << @task
      flash[:success] = "Interest Indicated"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def interest_params
    params.require(:interest).permit(:task_id)
  end
end
