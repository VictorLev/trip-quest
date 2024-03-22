class ActualReward < ApplicationRecord
  belongs_to :strategic_point
  belongs_to :trip

  after_create :update_reward_point_count_on_trip
  after_destroy :update_reward_point_count_on_trip

  private

  def update_reward_point_count_on_trip
    trip.update_column(:reward_point, trip.sum_reward) # updates DB without callbacks being triggered on trip
  end
end
