class AddCategoryIdToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :category_id, :integer
  end
end
