class Book < ActiveRecord::Base
   
    attr_accessible :title, :isbn, :author, :publisher, :edition, :description, :category_attributes#, :isbn

    #validates_presence_of :title, :isbn, :author, :publisher, :edition, :description
    #validates_numericality_of :edition, :message => "The book edition has to be a number"
   
   	#for user listings
    has_many :user_books
    has_many :users, :through => :user_books  

    #for book categories
    has_many :book_categories
	has_many :categories, :through => :book_categories
    
    #for sphinx search
    define_index do
        # fields
        indexes title#, :sortable => true

    end

end
