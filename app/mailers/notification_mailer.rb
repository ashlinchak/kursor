class NotificationMailer < ActionMailer::Base

  default from: 'notify@kursor.org.ua'
  default to: 'info@kursor.org.ua'

  def provider_created(provider)
    @provider = provider
    mail(:subject => t(:'mailers.provider_created.subject'))
  end

  def tutor_created(tutor)
    @tutor = tutor
    mail(:subject => t(:'mailers.tutor_created.subject'))
  end

  def posting_created(posting)
    @posting = posting
    mail(:subject => t(:'mailers.posting_created.subject'))
  end

  def provider_approved(provider)
    @provider = provider
    mail(:subject => t(:'mailers.provider_approved.subject'))
  end

  def feedback(feedback)
    @feedback = feedback
    mail(:subject => t(:'mailers.feedback.subject'))
  end

end
