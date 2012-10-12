class Category < ActiveRecord::Base
  # attr_accessible :title, :body

	attr_accessible :name

    has_many :books, :through => :book_categories
    has_many :book_categories

end
