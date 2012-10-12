
class UserMailer < ActionMailer::Base
  default :from => "team@shelflet.com"
  
  def welcome_message(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end

  def contact_us_message(message)
    @message = message
    mail(:subject => "#{message.subject}", :to => "help@shelflet.com")
  end

end
