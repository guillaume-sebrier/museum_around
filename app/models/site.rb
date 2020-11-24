class Site < ApplicationRecord
  has_many :exhibitions, dependent: :destroy
end
