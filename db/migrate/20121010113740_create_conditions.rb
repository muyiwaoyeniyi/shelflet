class CreateConditions < ActiveRecord::Migration
 def change
    create_table :conditions do |t|
	
	     t.column :name, :string


      t.timestamps
    end
  end
end
