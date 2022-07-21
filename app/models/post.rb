class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :post_comments

  validates :title, presence: true
  validates :sentence, presence: true

  def get_post_image(width,height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width,height]).processed
  end


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(search,word)
    if search == "perfect_match"
      Post.where("title LIKE?", "#{word}").or(Post.where("sentence LIKE?", "#{word}"))
      #.where("sentence LIKE?", "#{word}")
    elsif search == "forward_match"
      Post.where("title LIKE?", "#{word}%").or(Post.where("sentence LIKE?", "#{word}%"))
    elsif search == "backward_match"
      Post.where("title LIKE?", "%#{word}").or(Post.where("sentence LIKE?", "%#{word}"))
    elsif search == "partial_match"
      Post.where("title LIKE?", "%#{word}%").or(Post.where("sentence LIKE?", "%#{word}%"))
    else
      Post.all
    end
  end
end
