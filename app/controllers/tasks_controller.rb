class TasksController < ApplicationController
  before_action :ensure_logged_in

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @user = current_user
    @task.user = @user

    if @task.save
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.paginate(page: params[:page])
  end

  def express_interest
    @user = current_user
    @task = Task.find(params[:id])

    if @user.tasks.exists?(@task.id) || (@task.user_id == @user.id)
      flash[:warning] = "You cannot take up your own request"
    elsif @user.interested_tasks.exists?(@task.id)
      flash[:warning] = "You have already expressed interest"
    else
      current_user.interested_tasks << @task
      flash[:success] = "Interest Indicated"
    end

    redirect_back(fallback_location: tasks_path)
  end

  private

  def task_params
    params.require(:task).permit(:from_address, :from_postal_code,
                                 :to_address, :to_postal_code,
                                 :price)
  end

end
