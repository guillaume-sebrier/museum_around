class Review < ApplicationRecord
  belongs_to :exhibition
  belongs_to :user
end
