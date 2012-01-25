class UserActivationMailer < ActionMailer::Base
  default :from => "noreply@kursor.org.ua"

  def activation_email(user)
    @user = user
    mail(:to => user.email, :subject => "Account Activation")
  end

end
