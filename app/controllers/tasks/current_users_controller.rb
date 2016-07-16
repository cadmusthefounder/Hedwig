class Tasks::CurrentUsersController < ApplicationController
  before_action :ensure_logged_in

  def index
    @title = 'My Tasks'
    @tasks = current_user.tasks.paginate(page: params[:page])
    render 'tasks/index'
  end
end
