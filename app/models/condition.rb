class Condition < ActiveRecord::Base
  # attr_accessible :title, :body

    attr_accessible :name

    has_one :user_book


end
