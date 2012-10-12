class AddIdToUserBookPhotos < ActiveRecord::Migration
  def change
    add_column :user_book_photos, :user_book_id, :integer
  end
end
