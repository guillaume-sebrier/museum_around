class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_many :friendships
  has_many :inverse_friendships, class_name: :friendship, foreign_key: :friend_id

  def friends
    friends_array = friendships.map { |friendship| friendship.friend }
    friends_array << inverse_friendships.map { |friendship| friendship.user }
    friends_array.compact
  end

end
