class Category < ActiveRecord::Base
  # attr_accessible :title, :body

	attr_accessible :name

    has_many :books, :through => :book_categories
    has_many :book_categories


    def self.tokens(query)
  	   	categories = where("name like ?", "%#{query}%")
  	   	if categories.empty?
     		[{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
  		else
    		categories
  		end
	end


	def self.ids_from_tokens(tokens)
      tokens = tokens.titleize
  		tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  		tokens.split(',')
	end
end
