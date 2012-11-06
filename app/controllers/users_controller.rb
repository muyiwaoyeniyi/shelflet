class UsersController < ApplicationController

  load_and_authorize_resource    

  def index
     @users = User.all #paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @user = User.new
  end

  def show    
    @user = User.find(params[:id])
    @user_books = UserBook.where(:user_id => current_user).paginate(:page => params[:page], :per_page => 10)  #find_all_by_user_id(@user.id, :include => [:book])   #find user's books for shelf view
    @user_books_count = @user_books.count      #for shelf Nav count
  end  
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @user.update_with_password(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
   User.find(params[:id]).destroy
   flash[:success] = "User destroyed."
   redirect_to users_path
  end



end


