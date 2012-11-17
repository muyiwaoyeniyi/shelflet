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
          flash[:error] = "We couldn't add your book. You may have left out some required fields. Please re-enter the book information"
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

=begin
  require 'socket'

  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end
=end
  
end
