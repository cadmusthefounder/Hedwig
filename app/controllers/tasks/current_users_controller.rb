class Tasks::CurrentUsersController < ApplicationController
  before_action :ensure_logged_in

  def index
    @title = 'My Tasks'

    sort_attribute = params[:sort] || "created_at"
    sort_direction = params[:direction] || "DESC"

    @tasks = current_user.tasks.order(sort_attribute => sort_direction)
                               .paginate(:per_page => 5, :page => params[:page])
    @tasks = @tasks.search(params[:search]) if params[:search]

    render 'tasks/index'
  end
end
