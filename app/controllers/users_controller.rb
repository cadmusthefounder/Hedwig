class UsersController < ApplicationController
  before_action :ensure_logged_in

  def show
    @user = current_user
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
