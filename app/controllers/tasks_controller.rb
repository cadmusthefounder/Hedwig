class TasksController < ApplicationController
  before_action :ensure_logged_in, except: :index

  def index
    @title = "All Tasks"
    @tasks = Task.paginate(page: params[:page])
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

  def assign
    @task = Task.find(params[:id])
    @user = User.find(params[:user_id])

    unless @task.user == current_user
      flash[:error] = "This is not your task"
      return render 'show'
    end

    if @user == current_user
      flash[:warning] = "You cannot assign to yourself"
      return render 'show'
    end

    unless @task.interests.find_by(user: @user)
      flash[:warning] = "The user is not interested in this task"
      return render 'show'
    end

    @task.status = :assigned
    @task.assigned_user = @user
    @task.save

    render 'show'
  end

  def accept_assignment
    @task = Task.find(params[:id])

    unless @task.assigned_user == current_user
      flash[:error] = "You cannot accept this task"
      return render 'show'
    end

    @task.status = :in_progress
    @task.save

    render 'show'
  end

  def reject_assignment
    @task = Task.find(params[:id])

    unless @task.assigned_user == current_user
      flash[:error] = "You cannot reject this task"
      return render 'show'
    end

    @task.status = :brand_new
    @task.assigned_user = nil
    @task.save

    render 'show'
  end

  private

  def task_params
    params.require(:task).permit(:from_address, :from_postal_code,
                                 :to_address, :to_postal_code,
                                 :price)
  end

end
