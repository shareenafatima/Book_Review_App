class AddReviewsCountToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :reviews_count, :integer
  end
end
