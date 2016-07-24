class UsersController < ApplicationController
  before_action :ensure_logged_in

  def show
    sort_attribute = "updated_at"
    sort_direction = "DESC"

    @user = User.find(params[:id])
    @reviews = @user.reviews.order(sort_attribute => sort_direction)
                            .paginate(:per_page => 5, :page => params[:page])

    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
