class Trip < ApplicationRecord
  belongs_to :car
  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?
  has_one_attached :photo
  has_many :actual_rewards, dependent: :destroy
  has_many :strategic_points, through: :actual_rewards
end
