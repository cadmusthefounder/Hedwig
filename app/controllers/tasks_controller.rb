class TasksController < ApplicationController
  before_action :ensure_logged_in, except: :index

  def index
    params[:sort] ||= "created_at"
    params[:direction] ||= "ASC"

    if params[:search]
      @tasks = Task.search(params[:search]).order(params[:sort] => params[:direction]).paginate(:per_page => 5, :page => params[:page])
    else
      @tasks = Task.order(params[:sort] => params[:direction]).paginate(:per_page => 5, :page => params[:page])
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
