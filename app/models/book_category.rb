class BookCategory < ActiveRecord::Base
  # attr_accessible :title, :body


  	attr_accessible :category_id, :book_id

  	belongs_to :book
  	belongs_to :category
  	


end
