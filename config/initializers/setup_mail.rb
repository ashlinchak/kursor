ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 465,
  :domain               => "kursor.org.ua",
  :user_name            => "noreply@kursor.org.ua",
  :password             => "KuRs0r*pa88*w0rd",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "kursor.org.ua"
