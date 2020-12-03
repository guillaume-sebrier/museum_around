class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :exhibition
  validates :date, presence: :true
  validates :number_of_tickets, presence: :true
end
