class ThreadsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @threads = Interest.active.accessible_by(current_user).order(updated_at: :desc)
    @tasks = Task.where(id: @threads.pluck(:task_id))
    user_ids = @threads.pluck(:user_id) + @tasks.pluck(:user_id)
    @users = User.where(id: user_ids)
  end

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
