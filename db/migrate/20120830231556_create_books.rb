class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
	
	     t.column :title, :string, :null => false, :default => ""
       t.column :price, :float
       t.column :isbn, :string
	     t.column :category, :string

      t.timestamps
    end
  end
end
