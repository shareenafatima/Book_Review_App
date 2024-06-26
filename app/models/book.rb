class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :category
  has_one_attached :image
  CATEGORY = %W{Fiction Non-Fiction Classic Science-Fiction Mystery Fantasy Thriller Horror Biography Self-Help}
end
