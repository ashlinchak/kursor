class NotificationMailer < ActionMailer::Base
  default from: "notify@example.com"
  default to: 'info@kursor.org.ua'

  def provider_created(provider)
    @mailto = 'info@kursor.org.ua'
    @provider_path = provider_url(provider, :host => root_url)
    @provider_name = provider.name
    mail(:subject => "Provider created and must be approved")
  end

end
