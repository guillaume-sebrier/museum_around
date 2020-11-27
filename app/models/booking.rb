class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :exhibition
  validates :date, :time, presence: :true
end
