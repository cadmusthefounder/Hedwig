class AssignedTasks::CurrentUsersController < ApplicationController
  before_action :ensure_logged_in

  def index
    @title = 'Tasks Assigned to Me'
    @tasks = current_user.assigned_tasks.paginate(page: params[:page])
    render 'tasks/index'
  end
end
