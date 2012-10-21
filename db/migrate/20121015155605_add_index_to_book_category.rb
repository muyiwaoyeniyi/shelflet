class AddIndexToBookCategory < ActiveRecord::Migration
  def change
  	add_index :book_categories, :book_id
  	add_index :book_categories, :category_id
  end
end
