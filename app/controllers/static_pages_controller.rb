class StaticPagesController < ApplicationController
  def home
    @recentListings = UserBook.new.recent_Listings
  end

  def about
  end

  def terms
  end

  def privacy
  end

  def howitworks
  end

  def faqs
  end

  def to_404
  	render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def index    #for list page google books suggestion
    if params[:dummy] == 'a'
    else
     render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end 
  end

end
