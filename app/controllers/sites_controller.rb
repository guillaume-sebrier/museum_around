class SitesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def show
    @site = Site.find(params[:id])
  end
end
