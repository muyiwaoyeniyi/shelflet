class UserBookPhoto < ActiveRecord::Base

  #review this
  #default_scope order: 'user_book_photos.user_book_id'   

  attr_accessible :photo          #, :photo_file_name

  belongs_to :user_book
  has_attached_file :photo, 
  					:url => "/assets/photos/:id/:style/:basename.:extension", 
  					:path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
  
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

end
