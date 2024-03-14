class PlannedRoute < ApplicationRecord
  belongs_to :user
  has_many :projected_rewards, dependent: :destroy
  has_many :strategic_points, through: :projected_rewards


  def sum_reward
    sum = 0
    self.projected_rewards.each do |pr|
      sum += pr.strategic_point.danger
    end
    sum
  end
end
