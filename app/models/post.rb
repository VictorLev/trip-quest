class Post < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  has_one_attached :photo
end
