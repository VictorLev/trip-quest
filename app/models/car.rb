class Car < ApplicationRecord
  belongs_to :user
  belongs_to :insurer
  has_one_attached :photo

  validates :year, presence: true
end
