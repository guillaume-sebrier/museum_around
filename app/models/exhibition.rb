class Exhibition < ApplicationRecord
  CATEGORIES = ['Peinture', 'Sculpture', 'Street-Art', 'Contemporain', 'Design', 'Photographie', 'Architecture', 'Cinema', 'Histoire', 'Musique']
  belongs_to :site
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  # validates :category, inclusion: { in: CATEGORIES }
  geocoded_by :address
  after_validation :geocode
end
