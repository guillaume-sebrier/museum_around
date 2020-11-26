class FriendshipsController < ApplicationController

  def new
  end

  def create
  end

  def index
    @my_friendships = current_user.friendships
  end
end

