class ProviderRequestMailer < ActionMailer::Base

  default :from => "request@kursor.org.ua"

  def new_request(request)
    @message = request
    @subject = t(:'mailers.provider_request.subject')
    @email = 'info@kursor.org.ua'
    mail(:to => @email, :subject => @subject)
  end

end
