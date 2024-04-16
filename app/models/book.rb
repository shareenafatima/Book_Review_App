class Book < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category
  CATEGORY = %W{Fiction Non-Fiction Classic Science-Fiction Mystery Fantasy Thriller Horror Biography Self-Help}
end
