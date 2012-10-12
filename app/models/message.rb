class Message
  # attr_accessible :title, :body

  include ActiveAttr::Model
  
  attribute :name
  attribute :email
  attribute :subject
  attribute :content
   
  attr_accessible :name, :email, :subject, :content

  validates_presence_of :name, :email, :subject, :content
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
	  
end
