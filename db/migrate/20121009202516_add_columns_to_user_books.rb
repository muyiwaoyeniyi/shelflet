class AddColumnsToUserBooks < ActiveRecord::Migration
  def change
  	add_column :user_books, :condition, :text
    add_column :user_books, :conditionNotes, :text
    add_column :user_books, :location, :string
    add_column :user_books, :duration1, :boolean
    add_column :user_books, :duration2, :boolean
    add_column :user_books, :duration3, :boolean
  end
end
