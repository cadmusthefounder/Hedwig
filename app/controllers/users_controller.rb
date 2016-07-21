class UsersController < ApplicationController
  before_action :ensure_logged_in
  before_action :correct_user, only: [:edit, :update]

  def index
    sort_attribute = params[:sort] || "name"
    sort_direction = params[:direction] || "ASC"

    @users = User.order(sort_attribute => sort_direction).paginate(:per_page => 5, :page => params[:page])
    @users = @users.search(params[:search]) if params[:search]

    render 'static_pages/home' unless logged_in?
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.paginate(:per_page => 5, :page => params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)

    # TODO redirect to somewhere more useful
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
