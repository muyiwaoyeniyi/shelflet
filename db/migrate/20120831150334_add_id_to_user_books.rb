class AddIdToUserBooks < ActiveRecord::Migration
  def change
    add_column :user_books, :book_id, :integer
  end
end
