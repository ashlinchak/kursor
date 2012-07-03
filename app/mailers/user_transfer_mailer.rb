class UserTransferMailer < ActionMailer::Base

  default :from => "info@kursor.org.ua"

  def transfer_email(user, password)
    @user = user
    @email = user.email
    @password = password
    @provider = user.provider
    mail(:to => @email, :subject => t(:'mailers.user_transfer.subject') )
  end

  def transfer_email_with_add_msg(user, password, add_msg)
      @user = user
      @email = user.email
      @password = password
      @provider = user.provider
      @add_msg = add_msg
      mail(:to => @email, :subject => t(:'mailers.user_transfer.subject') )
    end

end
