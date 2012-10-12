class CreateUserBookPhotos < ActiveRecord::Migration
  def change
    create_table :user_book_photos do |t|

      t.timestamps
    end
  end
end
