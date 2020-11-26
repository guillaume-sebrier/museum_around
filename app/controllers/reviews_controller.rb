class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_review, only: %i[show destroy update edit]

  def show
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "Thank you for your contribution !"
    else
      flash[:alert] = "Something went wrong."
      # render :new, @booking: Booking.find(params[:booking_id])
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

