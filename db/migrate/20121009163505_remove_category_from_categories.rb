class RemoveCategoryFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :category
      end

  def down
    add_column :categories, :category, :string
  end
end
