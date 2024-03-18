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

  def total_rewards
    # Iterate through each of the cars belonging to this user
    # Iterate through each of the trips belonging to this car
    # Access the reward_point of each trip
    # Sum all the points
    # Return the sum
    sum = 0
    cars.each do |car|
      car.trips.each do |trip|
        sum += trip.reward_point
      end
    end
    sum
  end
end
