class GoogleBooksApiController < ApplicationController


 # GET /user_books
  # GET /user_books.json
  def index
   if params.has_key?(:value) && params[:value].strip != ""
     text = params[:value]   #fix security
     @response =  HTTParty.get('https://www.googleapis.com/books/v1/volumes?q=' + 
     	           text + '&fields=kind,items(volumeInfo/title),items(volumeInfo/authors),items(volumeInfo/publisher),items(volumeInfo/description),items(volumeInfo/categories),items(volumeInfo/industryIdentifiers),items(volumeInfo/imageLinks/thumbnail)' + '&maxResults=8' + '&key=AIzaSyCC5GZYiojTOSgN1nGr_hcII98-0IRbi9U')

     respond_to do |format|
        format.html { render :layout => false }
        format.json { render json: @user_books }
      end

   else

     render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false

   end     

  

  end

end
