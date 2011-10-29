ActionMailer::Base.smtp_settings = {
  :address              => "mail.kursor.org.ua",
  :port                 => 19,
  :domain               => "kursor.org.ua",
  :user_name            => "info@kursor.org.ua",
  :password             => "R67iUpOY",
  :authentication       => "plain",
  :enable_starttls_auto => true
}