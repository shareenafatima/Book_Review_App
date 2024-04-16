class AddUserIdToBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :user, null: false, foreign_key: true,  null: true
  end
end
