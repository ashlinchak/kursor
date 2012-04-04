#ActionMailer::Base.smtp_settings = {
#  :address              => "smtp.gmail.com",
#  :port                 => 587,
#  :domain               => "kursor.org.ua",
#  :user_name            => "noreply@kursor.org.ua",
#  :password             => "KuRs0r*pa88*w0rd",
#  :authentication       => "plain",
#  :enable_starttls_auto => true
#}

ActionMailer::Base.smtp_settings = {
    :address              => "mail.brainbox.com.ua",
    :port                 => 26,
    :domain               => "brainbox.com.ua",
    :user_name            => "kursor+brainbox.com.ua",
    :password             => "$ZGy%ZKuu&TE",
    :authentication       => "plain",
    :enable_starttls_auto => true
}



