class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  # belongs_to :user
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

end
