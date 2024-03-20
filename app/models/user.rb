class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :cars, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :planned_routes, dependent: :destroy
  has_many :trips, through: :car

  has_many :projected_rewards, through: :planned_routes
  has_many :trips, through: :cars

  def level
    total_rewards / 1000
  end

  def total_rewards
    (trips.joins(:car).sum(:reward_point))
  end
end
