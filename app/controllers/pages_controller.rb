class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @last_chance_exhibitions = Exhibition.order(:ending_date).first(10)
    @suggested_exhibitions = Exhibition.last(10)
    @bookings = Booking.all
    @bookings_futur = Booking.where("date > ?", Date.today)
    @bookings_passed = Booking.where("date < ?", Date.today)
  end
end
