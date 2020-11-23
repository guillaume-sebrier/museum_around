class Exhibition < ApplicationRecord
  belongs_to :site
  has_many :bookings
end
