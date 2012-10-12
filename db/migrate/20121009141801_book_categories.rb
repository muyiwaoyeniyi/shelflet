class BookCategories < ActiveRecord::Migration
  
  def change
    create_table(:book_categories) do |t|

      t.references :category
      t.references :book
    end
  end
end
