class Restaurant < ApplicationRecord

  validates :name, presence: true,
                   length: {minimum: 2}, uniqueness: true

  def average_rating
    restaurant_reviews = Review.where(restaurant_id: self.id)
    if restaurant_reviews.length == 0
      return "No ratings yet for this restaurant"
    else
      restaurant_reviews.average(:rating)
    end
  end

  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
