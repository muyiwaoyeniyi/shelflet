class AddLocationcolumsToUserBook < ActiveRecord::Migration
  def change
    add_column :user_books, :city, :string
    add_column :user_books, :state, :string
    add_column :user_books, :country, :string
    add_column :user_books, :country_code, :string
    add_column :user_books, :lat, :string
    add_column :user_books, :lng, :string
  end
end
