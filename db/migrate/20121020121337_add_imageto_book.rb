class AddImagetoBook < ActiveRecord::Migration
  def up
  	add_column :books, :cover_image_uid,  :string
  end

  def down
  	remove_column :books, :cover_image_uid,  :string
  end
end
