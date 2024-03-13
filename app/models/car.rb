class Car < ApplicationRecord
  belongs_to :user
  belongs_to :insurer
  has_one_attached :photo
  has_many :trips

  validates :year, presence: true
end
