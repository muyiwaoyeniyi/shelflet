class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable
  # :lockable, :timeoutable          #***************add this *****************
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :school_or_city, :provider, :uid
  
  validates_presence_of :first_name, :last_name, :school_or_city

  has_many :user_books, :dependent => :destroy
  has_many :books, :through => :user_books
    
  #devise confirm! method overriden
  def confirm!
    welcome_message
    super
  end

  #for facebook login
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(first_name:auth.extra.raw_info.first_name,
                        last_name:auth.extra.raw_info.last_name,
                        provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         school_or_city:auth.info.location,
                         password:Devise.friendly_token[0,20]
                         )
  end
   user
  end

private

  def welcome_message
    UserMailer.welcome_message(self).deliver
  end

end
