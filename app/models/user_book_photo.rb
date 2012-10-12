class UserBookPhoto < ActiveRecord::Base

  #review this
  default_scope order: 'user_book_photos.user_book_id'   

  attr_accessible :photo, :photo_file_name

  belongs_to :user_book
  has_attached_file :photo, :styles => { :large => "800x800", :medium => "400x400>", :small => "200x200>" },
  					:url  => "/assets/user_book_photos/:id/:style/:basename.:extension",
                  	:path => ":rails_root/assets/user_book_photos/:id/:style/:basename.:extension"
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

end
