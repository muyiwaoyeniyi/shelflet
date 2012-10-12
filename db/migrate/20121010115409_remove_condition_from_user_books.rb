class RemoveConditionFromUserBooks < ActiveRecord::Migration
  def up
  	 remove_column :user_books, :condition
  end

  def down
  	add_column :user_books, :condition, :text
  end
end
