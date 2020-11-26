class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @exhibition = Exhibition.find(params[:exhibition_id])
    @booking.exhibition = @exhibition
    @booking.user = current_user
    if @booking.save!
      redirect_to dashboard_path
      flash[:notice] = "Your booking is confirmed !"
    else
      render :new
    end
  end

  def destroy
  end

  def edit
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to dashboard_path
  end

  def new
    @booking = Booking.new
    @exhibition = Exhibition.find(params[:exhibition_id])
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:starting_time, :number_visitors, :status)
  end
end
