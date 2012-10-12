class BookCategory < ActiveRecord::Base
  # attr_accessible :title, :body


  	belongs_to :book
  	belongs_to :category
  	


end
