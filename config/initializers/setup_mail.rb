ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "shelflet.herokuapp.com",
  :user_name            => "team@shelflet.com",
  :password             => "Wisdom20",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
