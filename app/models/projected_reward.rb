class ProjectedReward < ApplicationRecord
  belongs_to :strategic_point
  belongs_to :planned_route
end
