class Trip < ApplicationRecord
  belongs_to :car
  has_one_attached :photo
  has_many :actual_rewards, dependent: :destroy
  has_many :strategic_points, through: :actual_rewards

  attr_accessor :start_date, :end_date

  def sum_reward
    actual_rewards.sum
  end
end
