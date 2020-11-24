class FavoritesController < ApplicationController
  def index
    @my_favorites = current_user.favorites
  end

  def new
  end

  def create
  end

  def destroy
  end
end
