class ApplicationController < ActionController::Base

  protect_from_forgery

  def after_sign_in_path_for(user)

    # Check to see if there is a temporary user_book saved in the session
    if session[:user_book].present?  
       
        @user_book = UserBook.new(session[:user_book]["user_book"]) 
        @user_book = current_user.user_books.build(session[:user_book]["user_book"])
        session[:user_book] = nil  
        if @user_book.save
          flash[:notice] = "Sweet, You have logged in and listed your book. You can add photos, list more or go to your shelf. :)"
          new_user_book_path
        else
          flash[:alert] = "We couldn't save your book. You may have left out some required fields. Please reenter the book information"
          flash[:notice] = ""
          new_user_book_path
        end
    else
      # If there is not a temp user_book in the session proceed as normal
      user
    end

  end


  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
    ## this render call should be:
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

end
