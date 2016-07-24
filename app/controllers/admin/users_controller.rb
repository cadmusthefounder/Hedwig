class Admin::UsersController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin

  def index
    sort_attribute = params[:sort] || "name"
    sort_direction = params[:direction] || "ASC"

    @users = User.order(sort_attribute => sort_direction).paginate(:per_page => 5, :page => params[:page])
    @users = @users.search(params[:search]) if params[:search]

    render 'static_pages/home' unless logged_in?
  end
end
