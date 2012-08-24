# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  title       :string(32)       not null
#  price       :float
#  subject_id  :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

#httparty.get(....)

class Book < ActiveRecord::Base
  # attr_accessible :title, :body
  
   attr_accessible :title, :price, :description, :subject_id
   belongs_to :subject
   validates_presence_of :title
   validates_numericality_of :price, :message=>"Error Message"


   #def getGoogleBooks
	#puts "I am google"
	#return
end
