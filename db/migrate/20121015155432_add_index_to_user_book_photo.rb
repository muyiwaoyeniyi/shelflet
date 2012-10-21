class AddIndexToUserBookPhoto < ActiveRecord::Migration
  def change
  	add_index :user_book_photos, :user_book_id
  end
end
