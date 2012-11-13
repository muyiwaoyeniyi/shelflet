class BooksController < ApplicationController

  load_and_authorize_resource  
  # GET /books
  # GET /books.json
  def index
    if params.has_key?(:search) && params[:search].strip != ""     #for rental search across site
       @books = Book.search(params[:search], :match_mode => :any, :star => true, :page => params[:page], :per_page => 10)
       if (@books.count == 0)
          @books = nil
       end

    elsif params[:category]    #for category search
        @book_ids = BookCategory.where('category_id = ?', params[:category]).pluck(:book_id)
        if (@book_ids)
            @books = Book.where(:id => @book_ids).paginate(:page => params[:page], :per_page => 10)
            if (UserBook.find_by_book_id(@book_ids) == nil)
              @books = nil
            end
        else
          @books = nil
          #flash[:alert] = "We didn't find any book in this category :("  #not showing up
        end
    #elsif params[:value]                         #for autosuggest on search bar
     #  @books = Book.search(params[:value], :match_mode => :any, :star => true)
    else    
       @books = Book.where(:id => [1..191]).paginate(:page => params[:page], :per_page => 10)  #paginate(:page => params[:page], :per_page => 1)    #(limit: 10)
       flash.now[:alert] = "Please type in something to search. Some recent listings have been shown. Also, we just opened up the listing feature :)"
    end
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end

  end

  # GET /books/1
  # GET /books/1.json
  def show

    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])#666
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

end