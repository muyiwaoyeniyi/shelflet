class RemovePriceFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :price
      end

  def down
    add_column :books, :price, :float
  end
end
