class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: :friendship, foreign_key: :friend_id
  has_many :favorites, dependent: :destroy
  has_many :exhibitions, through: :favorites
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  def friends
    friends_array = friendships.map { |friendship| friendship.friend }
    friends_array << inverse_friendships.map { |friendship| friendship.user }
    friends_array.compact
  end

end
