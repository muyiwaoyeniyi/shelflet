class GoogleBooksApiController < ApplicationController


 # GET /user_books
  # GET /user_books.json
  def index

   text = params[:value]   #fix security
   @response =  HTTParty.get('https://www.googleapis.com/books/v1/volumes?q=' + 
   	           text + '&fields=kind,items(volumeInfo/title)' + '&maxResults=7')
  
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render json: @user_books }
    end

  #@skip_footer = true

  end

end
