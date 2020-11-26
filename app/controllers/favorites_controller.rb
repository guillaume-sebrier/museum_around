class FavoritesController < ApplicationController

  def index
    @my_favorites = current_user.favorites
    aut
  end

  def new
  end

  def create
  end

  def destroy
  end
end
