class Car < ApplicationRecord
  belongs_to :user
  belongs_to :insurer
  has_one_attached :photo
  has_many :trips, dependent: :destroy
  has_many :actual_rewards, through: :trips

  validates :year, presence: true

  def total_car_reward
    trips.sum(:reward_point)
  end
end
