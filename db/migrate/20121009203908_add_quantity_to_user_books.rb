class AddQuantityToUserBooks < ActiveRecord::Migration
  def change
    add_column :user_books, :quantity, :integer
  end
end
