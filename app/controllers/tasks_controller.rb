class TasksController < ApplicationController
  before_action :ensure_logged_in, except: :index

  def index
    @title = "All Tasks"

    sort_attribute = params[:sort] || "created_at"
    sort_direction = params[:direction] || "DESC"

    new_tasks = Task.brand_new.where.not(user: current_user)
    active_tasks_assigned_to_me = Task.where.not(status: :completed)
                                      .where(assigned_user: current_user)

    @tasks = new_tasks.or(active_tasks_assigned_to_me)
                      .order(sort_attribute => sort_direction)
                      .paginate(:per_page => 5, :page => params[:page])

    @tasks = @tasks.search(params[:search]) if params[:search]

    render 'static_pages/home' unless logged_in?
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.price > current_user.credit
      @task.errors.add(:price, :too_high, message: "is higher than your available credit")
      render 'new'
    elsif @task.save
      current_user.credit -= @task.price
      current_user.save
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

  def complete_task
    @task = Task.find(params[:id])

    unless @task.assigned_user == current_user
      return render json: {
        error: 'You cannot complete this task.'
      }, status: :forbidden
    end

    unless @task.in_progress?
      return render json: {
        error: 'You have to accept this task first.'
      }, status: :bad_request
    end

    if @task.completion_token == params[:completion_token]
      @task.status = :completed
      @task.save

      current_user.credit += @task.list_price
      current_user.save
    else
      render json: {
        error: 'Invalid completion token'
      }, status: :bad_request
    end
  end

  private

  def task_params
    params.require(:task).permit(:from_address, :from_postal_code,
                                 :to_address, :to_postal_code,
                                 :price)
  end

end
