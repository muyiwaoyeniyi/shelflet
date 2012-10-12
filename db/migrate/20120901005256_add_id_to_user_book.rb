class AddIdToUserBook < ActiveRecord::Migration
  def change
    add_column :user_books, :user_id, :integer
  end
end
