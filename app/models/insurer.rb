class Insurer < ApplicationRecord
  has_many :cars, dependent: :destroy
end
