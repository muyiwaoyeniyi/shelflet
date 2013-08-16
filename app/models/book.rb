require "uri"

class Book < ActiveRecord::Base
   
    attr_accessible :title, :isbn, :author, :publisher, :edition, :description, :category_attributes, :cover_photo

    #validates_presence_of :title, :isbn, :author, :publisher, :edition, :description
    #validates_numericality_of :edition, :message => "The book edition has to be a number"
   
    #for user listings
    has_many :user_books
    has_many :users, :through => :user_books  

    #for book categories
    has_many :book_categories
	has_many :categories, :through => :book_categories


    has_attached_file :cover_photo, :styles => { :cover => "97x125#", :thumbnail => "88x114#" },
                      :storage => :s3,
                        :s3_credentials => "#{Rails.root}/config/s3.yml",
                        :path => "/cover/:style/:id/:filename",
                        :s3_protocol => 'https'

  
    validates_attachment_size :cover_photo, :less_than => 2.megabytes
    validates_attachment_content_type :cover_photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
    
    
    #for sphinx search
    define_index do

        # fields
        indexes title#, :sortable => true
        indexes isbn
        indexes author

    end


    def get_cover_photo_from_google(url)
      self.cover_photo = URI.parse(url)
    end

end
