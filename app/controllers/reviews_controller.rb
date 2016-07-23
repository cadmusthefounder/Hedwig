class ReviewsController < ApplicationController
  before_action :ensure_logged_in
  before_action :set_user
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    if current_user.can_write_review_for(@user)
      @review = Review.new
    else
      redirect_to @user
    end
  end

  def create
    @review = Review.new(review_params)
    @review.owner_id = current_user.id
    @review.user_id = @user.id

    if @review.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    unless current_user.can_write_review_for(@user)
      redirect_to @user
    end
  end

  def update
    if @review.update_attributes(review_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to user_path(@user)
  end


  private
    # Use callbacks to share common setup or constraints between actions.

    def set_review
      @review = @user.reviews.where(owner_id: current_user.id)[0]
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
