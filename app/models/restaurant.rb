class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true,
                   length: {minimum: 2}, uniqueness: true
end
