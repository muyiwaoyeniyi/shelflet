class AddAttachmentPhotoToUserBookPhotos < ActiveRecord::Migration
  def self.up
    change_table :user_book_photos do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :user_book_photos, :photo
  end
end
