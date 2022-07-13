class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user
  validates :title, presence: true
  validates :sentence, presence: true
end
