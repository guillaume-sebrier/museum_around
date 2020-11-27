class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: %i[show destroy update edit]

  def index
    if params[:search] && params[:search][:address].present?
      # search_address = Geocoder.search(params[:search][:address])
      # search_address.first.coordinates
      @sites = Site.near(params[:search][:address], 2)
    else
      @sites = Site.all
    end

    if params[:category]
      @exhibitions = Exhibition.where(category: params[:category])
    elsif params[:search] && params[:search][:address].present?
      @exhibitions = Exhibition.where(site_id:@sites.map(&:id))
    else
      @exhibitions = Exhibition.all
    end

    @markers_site = @sites.geocoded.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude,
        infoWindow: render_to_string(partial: "info_window_site", locals: { site: site }),
        image_url: helpers.asset_url('pin-sites.png')
      }
    end

    @markers_exhibition = @exhibitions.map do |exhibition|
      {
        lat: exhibition.site.latitude,
        lng: exhibition.site.longitude,
        infoWindow: render_to_string(partial: "info_window_exhibition", locals: { exhibition: exhibition }),
        image_url: helpers.asset_url('pin-exhibitions.png')
      }
    end

    if params[:category]
      @markers = @markers_exhibition
    else
      @markers = @markers_site + @markers_exhibition
    end
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
end
