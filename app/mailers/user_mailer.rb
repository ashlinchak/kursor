class UserMailer < ActionMailer::Base
  default :from => "info@kursor.org.ua"

  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end
end
