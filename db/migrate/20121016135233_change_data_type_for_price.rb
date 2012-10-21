class ChangeDataTypeForPrice < ActiveRecord::Migration
  def up
  	change_table :user_books do |t|
      t.change :price, :integer
    end
  end

  def down
  	change_table :user_books do |t|
      t.change :price, :integer
    end
  end
end
