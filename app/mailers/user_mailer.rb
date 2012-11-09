
class UserMailer < ActionMailer::Base
  default :from => "team@shelflet.com"
  
  def welcome_message(user)
    @user = user
    #attachments.inline["shelflet.jpg"] = File.read("#{Rails.root}/public/assets/shelflet.jpg")  
    mail(:to => user.email, :subject => "Shelflet | Welcome to our Alpha launch")
  end

  def contact_us_message(message)
    @message = message
    mail(:subject => "#{message.subject}", :to => "help@shelflet.com", :reply_to => "#{message.email}")
  end

end
