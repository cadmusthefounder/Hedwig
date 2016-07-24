class AssignedTasks::CurrentUsersController < ApplicationController
  before_action :ensure_logged_in

  def index
    @title = 'Tasks Assigned to Me'

    sort_attribute = params[:sort] || "created_at"
    sort_direction = params[:direction] || "DESC"

    @tasks = current_user.assigned_tasks.order(sort_attribute => sort_direction)
                               .paginate(:per_page => 5, :page => params[:page])
    @tasks = @tasks.search(params[:search]) if params[:search]

    render 'static_pages/home' unless logged_in? else render 'tasks/index'
  end
end
