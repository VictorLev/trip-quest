class ActualReward < ApplicationRecord
  belongs_to :strategic_point
  belongs_to :trip
end
