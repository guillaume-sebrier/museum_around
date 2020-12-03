class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @index = true
  end

  def dashboard
    @last_chance_exhibitions = Exhibition.includes([:site]).where("ending_date > ?", Date.today).order(:ending_date).first(10)
    @suggested_exhibitions = Exhibition.last(10)
    @bookings = Booking.includes([:exhibition]).where(user: current_user)
    @bookings_futur = @bookings.where("date > ?", Date.today).sort_by{ |booking| booking.date }
    @bookings_passed = @bookings.where("date < ?", Date.today)
  end

  def favorites
    @favorites = Favorite.all
  end
end
