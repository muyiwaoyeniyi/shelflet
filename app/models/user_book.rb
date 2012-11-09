class UserBook < ActiveRecord::Base  
  
  default_scope order: 'user_books.created_at DESC'

  #attributes
  attr_accessible :price, :quantity, :conditionNotes, :condition_id, :user_book_photos_attributes
  attr_accessible :location, :duration1, :duration2, :duration3
  attr_accessible :title, :category, :otherCategory, :isbn, :author, :publisher, :edition, :description #for setting book model
  attr_accessible :wrongCover, :No_Edition, :deletePhotos, :cover_photo_url
  attr_accessible :duration    #will be used for cart and orders


  attr_accessor :title, :category, :otherCategory, :isbn, :author, :publisher, :edition, :description, :No_Edition  #for setting book model
  attr_accessor :wrongCover, :deletePhotos, :cover_photo_url  #for handling photos
  attr_accessor :duration   #will be used for cart and orders
  #attr_accessor :suggestedPrice  #will be used for rental price suggestion api


  #stripping
  auto_strip_attributes :price, :quantity, :conditionNotes, :location, :nullify => false, :squish => true
  auto_strip_attributes :title, :otherCategory, :author, :nullify => false, :squish => true
  auto_strip_attributes :publisher, :edition, :description, :nullify => false, :squish => true
  before_validation :the_stripper


  #Validation
  validates_presence_of :price, :location, :quantity, :condition_id
  validates_numericality_of :price, :quantity, :message => "has to be a number"
  validate :at_least_one_duration_must_be_checked

  
  #validations for book and category models
  validates_presence_of :title, :category, :author, :description
  validates :isbn, :isbn_format => true
  validates_presence_of :otherCategory, :if => lambda { self.category == "1000" }  
  validates_presence_of :edition, :if => lambda { self.No_Edition == "0" }
  validates_numericality_of :edition, :if => lambda { self.No_Edition == "0" }, :message => "has to be a number"


  #Associations
  belongs_to :user
  belongs_to :book
  has_many :user_book_photos, :dependent => :destroy
  belongs_to :condition
  accepts_nested_attributes_for :user_book_photos, :allow_destroy => true
  

  #callbacks
  before_save :set_book_and_category
  before_save :delete_photos


  #functions
  #def from_cheapbooks  #for price suggestion
      #response =  HTTParty.get('http://api.cheapbooks.com/api.cgi?isbn=0538493720&condition=rental')#&condition=rental')
      #suggestedPriceFromApi = "4 - 5"
      #self.suggestedPrice = suggestedPriceFromApi 
  #end

  def recent_Listings     #for homepage
      UserBook.all(limit: 5)
  end

  def user_books_count(current_user)   #for shelf Nav count
      UserBook.find_all_by_user_id(current_user).count
  end
  

protected

 def at_least_one_duration_must_be_checked
    unless duration1 || duration2 || duration3
       errors.add(:base, "Please select at least one duration")
    end
 end

 def the_stripper       #remove leading and trailing whitespaces
     self.isbn = self.isbn.strip.to_s.upcase
     self.author = self.author.titleize
     self.publisher = self.publisher.titleize
 end

 def delete_photos
    if self.deletePhotos
        UserBookPhoto.delete_all(:user_book_id => @user_book.id)
    end
 end


 def set_book_and_category
   
    @book = Book.find_by_isbn(self.isbn)      #check if book exist first...
    
    if !(@book)                     #if book does not exist, create new book

      if self.No_Edition       #set edition to zero if book has no edition
        self.edition = 0
      end

      @book = Book.new(:title => self.title, :isbn => self.isbn, 
                      :publisher => self.publisher, :edition => self.edition, 
                      :author => self.author, :description => self.description)

      if (cover_photo_url != '' && cover_photo_url != nil)      #check if url contains a string
        @book.get_cover_photo_from_google(self.cover_photo_url)
      end

      @book.save!

      #create a new category only if user selects other category or google returns a category and if that category doesnt already exist
      if (self.category == "1000")      
        self.otherCategory = self.otherCategory.titleize
        @checkCategory = Category.where("name = ?", self.otherCategory)
        if @checkCategory == nil
          @category = Category.create(:name => self.otherCategory)
          @book_category = BookCategory.create(:category_id => @category.id, :book_id => @book.id) 
        else
          @book_category = BookCategory.create(:category_id => @checkCategory.first.id, :book_id => @book.id) 
        end
      end       #end if for category     
     
    end  #end if for book
    
    #set user book and book association
    self.book_id = @book.id

  end    #end set_book_and_category

  #for changing other category validation message
  HUMANIZED_ATTRIBUTES = {
    :otherCategory => "Other Category"
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  #end for changing other category validation message

end

=begin
    self.location = self.location.to_s.strip
    self.quantity = self.quantity.to_s.strip
    self.conditionNotes = self.conditionNotes.to_s.strip

    self.title = self.title.to_s.strip
    self.isbn = self.isbn.strip.to_s.upcase
    self.publisher = self.publisher.to_s.strip
    self.edition = self.edition.to_s.strip
    self.author = self.author.to_s.strip
    self.description = self.description.to_s.strip
    self.otherCategory = self.otherCategory.to_s.strip
=end