class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :exhibition
  validates :date, presence: :true
end
