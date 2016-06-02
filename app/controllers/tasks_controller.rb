class TasksController < ApplicationController
  before_action :ensure_logged_in

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

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
    @tasks = Task.all
  end


  private

  def task_params
    params.require(:task).permit(:from_address, :from_postal_code,
                                 :to_address, :to_postal_code,
                                 :price)
  end

end