class UserMailer < ActionMailer::Base
  default :from => "noreply@kursor.org.ua"

  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end
end
