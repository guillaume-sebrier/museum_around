class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: %i[show destroy update edit]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @exhibitions = nil
    @sites = nil
    @museum = false
    @markers_site = []
    @markers_exhibition = []

    if params[:search].present?

      if params[:search][:museum].present? && params[:search][:museum].include?("1")
        @sites = Site.where(fake: false)
        @museum = true
      end

      @categories = Exhibition::CATEGORIES.select { |category| params[:search][category] == '1' }
      @exhibitions = Exhibition.where(category: @categories)
      if params[:search][:address].present?
        @sites = Site.near(params[:search][:address], 6)
        @museum = true
        @exhibitions = Exhibition.where(site_id: @sites.map(&:id))
        @categories = Exhibition::CATEGORIES
      end

    elsif params[:category].present?
      @exhibitions = Exhibition.where(category: params[:category])
      @categories = params[:category]
      @joconde = true
    else
      @exhibitions = Exhibition.all
      @categories = Exhibition::CATEGORIES
      @sites = Site.where(fake: false)
      @museum = true
      @joconde = true
    end

    set_favorites
    define_markers
  end

  def show
    @review = Review.new
    set_favorite
  end

  def destroy
    @exhibition.destroy
    redirect_to exhibitions_path
  end

  def edit
    @sites = Site.all
  end

  def update
    @site = Site.find(params[:exhibition][:site_id].to_i)
    @exhibition.update(exhibition_params)
    @exhibition.update(site: @site)
    redirect_to exhibition_path(@exhibition)
  end

  private

  def set_exhibition
    @exhibition = Exhibition.find(params[:id])
  end

  def exhibition_params
    params.require(:exhibition).permit(:title, :starting_date, :ending_date, :address, :fake, :description, :price, :category, :photo, :place, :date, site_attributes: [:id])
  end

  def define_markers
    if @sites
      @markers_site = @sites.map do |site|
        {
          lat: site.latitude,
          lng: site.longitude,
          infoWindow: render_to_string(partial: "info_window_site", locals: { site: site }),
          image_url: helpers.asset_url('green-pin.png'),
          category: 'Collection permanente',
          type_expo: 'Collection permanente'
        }
      end
    end

    if @exhibitions
      @markers_exhibition = @exhibitions.map do |exhibition|
        {
          lat: exhibition.latitude,
          lng: exhibition.longitude,
          infoWindow: render_to_string(partial: "info_window_exhibition", locals: { exhibition: exhibition }),
          image_url: helpers.asset_url('pin-exhibitions.png'),
          category: exhibition.category,
          type_expo: 'Collection temporaire'
        }
      end
    end

    @markers = @markers_site + @markers_exhibition
  end

  def set_favorite
    return unless user_signed_in?

    if Favorite.find_by(user: current_user, exhibition: @exhibition)
      @favorite = Favorite.find_by(user: current_user, exhibition: @exhibition)
    else
      @favorite = Favorite.new
    end
  end

  def set_favorites
    @favorites = current_user.favorites if user_signed_in?
  end
end
