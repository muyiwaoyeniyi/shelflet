class AddColumnsToBooks < ActiveRecord::Migration
  def change
	
	#add_column :books, :isbn, :string
    add_column :books, :author, :string
    add_column :books, :publisher, :string
    add_column :books, :edition, :integer
    add_column :books, :description, :text
  end
end
