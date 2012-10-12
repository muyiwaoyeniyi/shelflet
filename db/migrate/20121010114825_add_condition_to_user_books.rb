class AddConditionToUserBooks < ActiveRecord::Migration
  def change

  	add_column :user_books, :condition_id, :integer

  end
end
