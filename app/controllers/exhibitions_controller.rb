class ExhibitionsController < ApplicationController
  def index
    @exhibitions = Exhibition.all
    @sites = Site.all

    @markers = @sites.geocoded.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { site: site }),
        image_url: helpers.asset_url('map-pin.png')
      }
    end
  end

  def show
  end
end
