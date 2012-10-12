class UserBooksController < ApplicationController

   before_filter :authenticate_user!, except: [:index, :show, :new]
   
   load_and_authorize_resource  

  # GET /user_books
  # GET /user_books.json
  def index
    @user_books = UserBook.all
  
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_books }
    end
  end

  # GET /user_books/1
  # GET /user_books/1.json
  def show
    @user_book = UserBook.find(params[:id])
    @user_books_count = UserBook.new.user_books_count(current_user)   #for shelf Nav count
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_book }
    end
  end

  # GET /user_books/new
  # GET /user_books/new.json
  def new
      @user_book = UserBook.new   
      @user_book.from_cheapbooks     #for price suggestion
      @user_book.user_book_photos.build 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_book }
    end
  end

  # GET /user_books/1/edit
  def edit

    @user_book = UserBook.find(params[:id])
    @book = Book.find_by_id(@user_book.book_id)    
    @user_book.title = @book.title
    @user_book.author = @book.author
    @user_book.publisher = @book.publisher
    @user_book.description = @book.description
    @user_book.edition = @book.edition
    @user_book.isbn = @book.isbn
    @user_book.category = @book.categories.first.id   #would need to change this when we add multicategories

  end

  # POST /user_books
  # POST /user_books.json
  def create
    @user_book = UserBook.new(params[:user_book]) 
    @user_book = current_user.user_books.build(params[:user_book])      
        
    respond_to do |format|
      if @user_book.save
        format.html { redirect_to @user_book, notice: 'User book was successfully created.' }
        format.json { render json: @user_book, status: :created, location: @user_book }
      else
        format.html { render action: "new" }
        format.json { render json: @user_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_books/1
  # PUT /user_books/1.json
  def update
    @user_book = UserBook.find(params[:id])

    respond_to do |format|
      if @user_book.update_attributes(params[:user_book])
        format.html { redirect_to @user_book, notice: 'User book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_books/1
  # DELETE /user_books/1.json
  def destroy
    @user_book = UserBook.find(params[:id])
    @user_book.destroy

    respond_to do |format|
      format.html { redirect_to user_books_url }
      format.json { head :no_content }
    end
  end
end
