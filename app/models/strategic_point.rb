class StrategicPoint < ApplicationRecord
  has_many :projected_rewards, dependent: :destroy
  has_many :actual_rewards, dependent: :destroy
end
