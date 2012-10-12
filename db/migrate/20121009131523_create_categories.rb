class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

    	t.column :category, :string, :null => false


      t.timestamps
    end
  end
end
