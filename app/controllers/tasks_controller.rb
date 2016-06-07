class TasksController < ApplicationController
  before_action :ensure_logged_in

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @user = current_user
    @task.owner_id = @user.id

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

  def update
    @user = current_user
    @task = Task.find(params[:id])
    if @user.owned.exists?(@task.id) or (@task.owner_id == @user.id)
      flash[:warning] = "You cannot take up your own request"
      redirect_to :back
    elsif @user.tasks.exists?(@task.id)
      flash[:warning] = "You have already expressed interest"
      redirect_to :back
    else
      current_user.tasks << @task
      flash[:success] = "Interest Indicated"
      redirect_to :back
    end
  end

  private

  def task_params
    params.require(:task).permit(:from_address, :from_postal_code,
                                 :to_address, :to_postal_code,
                                 :price)
  end

end
