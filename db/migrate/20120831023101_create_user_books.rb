class CreateUserBooks < ActiveRecord::Migration
  def change
    create_table :user_books do |t|

       t.column :price, :float
       t.column :category, :string

      t.timestamps
    end
  end
end
