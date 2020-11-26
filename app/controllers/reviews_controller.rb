class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_review, only: %i[show destroy update edit]

  def show
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @exhibition = Exhibition.find(params[:exhibition_id])
    @review.exhibition = @exhibition
    if @review.save
      redirect_to exhibition_path(@exhibition)
      flash[:notice] = "Thank you for your contribution !"
    else
      flash[:alert] = "Something went wrong."
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "Thank you for your contribution !"
    redirect_to dashboard_path
  end

  def new
    @review = Review.new
    @exhibition = Exhibition.find(params[:exhibition_id])
  end

  def update
  end

  def edit
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :exhibition)
  end
end

