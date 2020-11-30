class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: %i[show destroy update edit]

  def index
    @exhibitions = nil
    @sites = nil
    @markers_site = []
    @markers_exhibition = []

    if params[:category] && params[:category] != ""
      @exhibitions = Exhibition.where(category: params[:category])
    elsif params[:search] && params[:search][:address].present?
      @sites = Site.near(params[:search][:address], 2)
      @exhibitions = Exhibition.where(site_id: @sites.map(&:id))
    elsif params[:expo] == "Collections temporaires"
      @exhibitions = Exhibition.all
    elsif params[:expo] == "Collections permanentes"
      @sites = Site.all
    else
      @exhibitions = Exhibition.all
      @sites = Site.all
    end
    define_markers
  end

  def show
    @review = Review.new
  end

  def destroy
    @exhibition.destroy
    redirect_to exhibitions_path
  end

  def edit
    @sites = Site.all
  end

  def update
    @site = Site.find(params[:exhibition][:site].to_i)
    @exhibition.update(exhibition_params)
    @exhibition.update(site: @site)
    redirect_to exhibition_path(@exhibition)
  end

  private

  def set_exhibition
    @exhibition = Exhibition.find(params[:id])
  end

  def exhibition_params
    params.require(:exhibition).permit(:title, :starting_date, :ending_date, :description, :price, :category, :photo, :place, :date, site_attributes: [:id])
  end

  def define_markers
    if @sites
      @markers_site = @sites.map do |site|
        {
          lat: site.latitude,
          lng: site.longitude,
          infoWindow: render_to_string(partial: "info_window_site", locals: { site: site }),
          image_url: helpers.asset_url('green-pin.png')
        }
      end
    end

    if @exhibitions
      @markers_exhibition = @exhibitions.map do |exhibition|
        {
          lat: exhibition.latitude,
          lng: exhibition.longitude,
          infoWindow: render_to_string(partial: "info_window_exhibition", locals: { exhibition: exhibition }),
          image_url: helpers.asset_url('pin-exhibitions.png')
        }
      end
    end

    @markers = @markers_site + @markers_exhibition
  end
end
