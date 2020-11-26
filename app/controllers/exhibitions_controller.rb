class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: %i[show destroy update edit]

  def index
    @exhibitions = Exhibition.all
    @sites = Site.all

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
    @markers = @markers_site + @markers_exhibition
  end

  def show
  end

  def destroy
    @exhibition.destroy
    redirect_to exhibitions_path
  end

  def edit
    @sites = Site.all
  end

  def update
    @exhibition.update(exhibition_params)
    redirect_to exhibition_path(@exhibition)
  end

  private

  def set_exhibition
    @exhibition = Exhibition.find(params[:id])
  end

  def exhibition_params
    params.require(:exhibition).permit(:title, :starting_date, :ending_date, :description, :price, :category, :photo, :place, :date, :site)
  end
end
