class ExhibitionsController < ApplicationController
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
end
