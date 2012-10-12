namespace :db do
   
  desc "fill database"
  task :populate => :environment do
   
  
  
  

  10.times do
       u = User.new(
          :first_name => Faker::Name.first_name,
          :last_name => Faker::Name.last_name,
           :school_or_city => Faker::Address.city,
          :email => Faker::Internet.email,
          :password => "qwerty"
        )       
        u.save!


  10.times do
      b = Book.create!(
          :title => Faker::Lorem.words(3).to_s.capitalize,
          :isbn => "55555555555555",
           :author => Faker::Name.name,
          :publisher => Faker::Name.name,
          :description => Faker::Lorem.sentences(5).join(" "),
          :edition => 1
        )       
        
    25.times do
      UserBook.create!(
          :price => (rand(25-1) + 1),
           :book_id => b.id,
          :user_id => u.id
        )       
    end
  end
  end



  end
end