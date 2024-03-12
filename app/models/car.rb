class Car < ApplicationRecord
  belongs_to :user
  belongs_to :insurer

  validates :year, presence: true
end
