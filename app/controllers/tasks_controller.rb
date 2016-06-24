class TasksController < ApplicationController
  before_action :ensure_logged_in, except: :index

  def index
    if params[:search]
      @tasks = Task.paginate(page: params[:page]).search(params[:search])
    else
      @tasks = Task.paginate(page: params[:page])
    end
    render 'static_pages/home' unless logged_in?
  end

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

  private

  def task_params
    params.require(:task).permit(:from_address, :from_postal_code,
                                 :to_address, :to_postal_code,
                                 :price)
  end

end
