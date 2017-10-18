class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, presence: true,
                   length: {minimum: 2}, uniqueness: true
end
