class UserBook < ActiveRecord::Base  
  
  default_scope order: 'user_books.created_at DESC'

  #attributes
  attr_accessible :price, :quantity, :conditionNotes, :condition_id
  attr_accessible :location, :duration1, :duration2, :duration3, :user_book_photos_attributes
  attr_accessible :title, :category, :otherCategory, :isbn, :author, :publisher, :edition, :description #for setting book model
  attr_accessible :duration    #will be used for cart and orders

  attr_accessor :title, :category, :otherCategory, :isbn, :author, :publisher, :edition, :description  #for setting book model
  attr_accessor :suggestedPrice  #will be used for rental price suggestion api
  attr_accessor :duration    #will be used for cart and orders

  
  #Validation
  validates_presence_of :price, :location, :quantity, :condition_id
  validates_numericality_of :price, :quantity, :message => "has to be a number"
  validate :at_least_one_duration_must_be_checked

  
  #validations for book and category models
  validates_presence_of :title, :category, :isbn, :author, :publisher, :edition, :description
  validates_numericality_of :edition, :message => "has to be a number"
  validates :otherCategory, :presence => true, :if => :check_if_category_is_other


  #Associations
  belongs_to :user
  belongs_to :book
  has_many :user_book_photos, :dependent => :destroy
  belongs_to :condition
  accepts_nested_attributes_for :user_book_photos, :allow_destroy => true

  
  #callbacks
  before_save :set_book_and_category




  #functions
  def from_cheapbooks  #for price suggestion
      #response =  HTTParty.get('http://api.cheapbooks.com/api.cgi?isbn=0538493720&condition=rental')#&condition=rental')
      #suggestedPriceFromApi = "4 - 5"
      #self.suggestedPrice = suggestedPriceFromApi 
  end

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

 def check_if_category_is_other
     self.category == 27
 end


 def set_book_and_category

    #create a new book  
     
     @book = Book.find_by_isbn(self.isbn)
    # if !@book?

     @book = Book.new(:title => self.title, :isbn => self.isbn, 
                      :publisher => self.publisher, :edition => self.edition, 
                      :author => self.author, :description => self.description)    
     @book.save!

    #create a new category only if user selects other category
     if (self.category == 27)
       @category = Category.new(:name => self.otherCategory)
       @category.save! 
       self.category = @category.id
     end

   #Set the book and category association
     @book_category = BookCategory.new
     @book_category.category_id = self.category
     @book_category.book_id = @book.id
     @book_category.save!
     #end
    #set user book and book association
     self.book_id = @book.id

end














end
