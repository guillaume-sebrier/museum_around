class Exhibition < ApplicationRecord
  belongs_to :site
  has_many :bookings
  has_many :reviews
  has_many :favorites

  geocoded_by :address

  def address
    site.address
  end
end
