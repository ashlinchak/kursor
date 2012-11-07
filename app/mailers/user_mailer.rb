class UserMailer < ActionMailer::Base

  default :from => "noreply@kursor.org.ua"

  def password_reset(user, password)
    @user = user
    @password = password
    mail(
        :to => user.email,
        :subject => t(:'devise.mailer.mass_password_reset.subject').html_safe
    )
  end

end