class Trip < ApplicationRecord
  belongs_to :car
  has_one_attached :photo
  has_many :actual_rewards, dependent: :destroy
  has_many :strategic_points, through: :actual_rewards

  def sum_reward
    sum = 0
    self.actual_rewards.each do |ar|
      sum += ar.strategic_point.danger
    end
    sum*50
  end
end
