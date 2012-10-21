class AddIndexToUserBook < ActiveRecord::Migration
  def change
  	add_index :user_books, :book_id
  	add_index :user_books, :user_id
  	add_index :user_books, :condition_id
  end
end
