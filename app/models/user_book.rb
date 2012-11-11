class UserBook < ActiveRecord::Base  
  
  default_scope order: 'user_books.created_at DESC'

  #attributes
  attr_accessible :price, :quantity, :conditionNotes, :condition_id, :user_book_photos_attributes
  attr_accessible :duration1, :duration2, :duration3
  attr_accessible :title, :isbn, :author, :publisher, :edition, :description #for setting book model
  attr_accessible :wrongCover, :No_Edition, :deletePhotos, :cover_photo_url, :category_tokens, :duration  #for setting multiple category #will be used for cart and orders                          
  attr_accessible :location, :city, :state, :country, :country_code, :lat, :lng
  #attr_accessible :suggestedPrice  #will be used for rental price suggestion api

  attr_accessor :title, :isbn, :author, :publisher, :edition, :description, :No_Edition  #for setting book model
  attr_accessor :wrongCover, :deletePhotos, :cover_photo_url  #for handling photos
  attr_accessor :category_tokens, :duration                               #for setting multiple category
  
  #stripping
  auto_strip_attributes :price, :quantity, :conditionNotes, :location, :nullify => false, :squish => true
  auto_strip_attributes :title, :author, :nullify => false, :squish => true
  auto_strip_attributes :publisher, :edition, :description, :nullify => false, :squish => true
  before_validation :the_stripper


  #Validation
  validates_presence_of :price, :location, :quantity, :condition_id
  validates_numericality_of :price, :quantity, :message => "has to be a number"
  validate :at_least_one_duration_must_be_checked

  
  #validations for book and category models
  validates_presence_of :title, :author, :description, :category_tokens
  validates :isbn, :isbn_format => true
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
  before_update :delete_photos


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
       errors.add(:base, "Please select one or more durations")
    end
  end

  def the_stripper       #remove leading and trailing whitespaces
     self.isbn = self.isbn.strip.to_s.upcase
     self.author = self.author.titleize
     self.publisher = self.publisher.titleize
  end

  def delete_photos
    if self.deletePhotos
         @user_book_photos = UserBookPhoto.where(:user_book_id => self.id)
         @user_book_photos.destroy_all
    end    
  end


 def set_book_and_category
   
    @book = Book.find_by_isbn(self.isbn)      #check if book exist first...
    
    if !(@book)                     #if book does not exist, create new book

      if self.No_Edition == "1"     #set edition to zero if book has no edition
        self.edition = 0
      end
      @book = Book.new(:title => self.title, :isbn => self.isbn, 
                      :publisher => self.publisher, :edition => self.edition, 
                      :author => self.author, :description => self.description)
      if (cover_photo_url != '' && cover_photo_url != nil)      #check if url contains a string
        @book.get_cover_photo_from_google(self.cover_photo_url)
      end
      #create a new category only if user selects other category or google returns a category and if that category doesnt already exist
      @book.category_ids = Category.ids_from_tokens(category_tokens)      
      @book.save!      
    else
      @book.category_ids = Category.ids_from_tokens(category_tokens)
    end  #end if for book
    
    self.book_id = @book.id           #set user book and book association

  end    #end set_book_and_category

  #for changing other category validation message

  HUMANIZED_ATTRIBUTES = {
    :category_tokens => "Category"
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

=begin
      if (self.category == "1000")      
        self.otherCategory = self.otherCategory.titleize
        @checkCategory = Category.find_by_name(self.otherCategory)
        if @checkCategory
           @book_category = BookCategory.create(:category_id => @checkCategory.id, :book_id => @book.id) 
        else
           @category = Category.create(:name => self.otherCategory)
           @book_category = BookCategory.create(:category_id => @category.id, :book_id => @book.id)           
        end
      else
        @category = Category.find_by_id(self.category)
        @book_category = BookCategory.create(:category_id => @category.id, :book_id => @book.id)         
      end       #end if for category     
=end