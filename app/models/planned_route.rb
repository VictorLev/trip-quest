class PlannedRoute < ApplicationRecord
  belongs_to :user
  has_many :projected_rewards, dependent: :destroy

end
