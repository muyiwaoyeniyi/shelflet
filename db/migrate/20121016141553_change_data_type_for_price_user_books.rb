class ChangeDataTypeForPriceUserBooks < ActiveRecord::Migration
  def up
  	change_table :user_books do |t|
      t.change :price, :decimal, :precision => 8, :scale => 2
    end
  end

  def down
  	change_table :user_books do |t|
      t.change :price, :decimal, :precision => 8, :scale => 2
    end
  end
end
