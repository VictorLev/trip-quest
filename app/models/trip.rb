class Trip < ApplicationRecord
  belongs_to :car
  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?
  has_many :actual_rewards, dependent: :destroy
end
