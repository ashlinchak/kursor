class UserTransferMailer < ActionMailer::Base

  default :from => "info@kursor.org.ua"

  def transfer_email(user, password)
    @user = user
    @email = user.email
    @password = password
    @provider = user.provider
    mail(:to => @email, :subject => t(:'mailers.user_transfer.subject') )
  end

end
