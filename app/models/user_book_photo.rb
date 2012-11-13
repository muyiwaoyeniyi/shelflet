class UserBookPhoto < ActiveRecord::Base

  #review this
  #default_scope order: 'user_book_photos.user_book_id'   

  attr_accessible :photo          #, :photo_file_name

  belongs_to :user_book
  has_attached_file :photo, :styles => { :cover => "97x125#", :thumbnail => "88x114#", :more => "800x520>" },
                      :storage => :s3,
                        :s3_credentials => "#{Rails.root}/config/s3.yml",
                        :path => "/UserBookPhoto/:style/:id/:filename",
                        :s3_protocol => 'https'
  
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

end
