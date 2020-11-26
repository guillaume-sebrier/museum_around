class Exhibition < ApplicationRecord
  CATEGORIES = ['Peinture', 'Sculpture', 'Street Art', 'Contemporain', 'Design', 'Photographie', 'Architecture', 'Cinéma', 'Histoire', 'Musique']
  belongs_to :site
  has_many :bookings
  has_many :reviews
  has_many :favorites

  validates :title, presence: true
  # validates :category, inclusion: { in: CATEGORIES }
end
