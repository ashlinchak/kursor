class NotificationMailer < ActionMailer::Base

  default from: 'notify@kursor.org.ua'
  default to: 'info@kursor.org.ua'

  @info = ''

  # For Admins

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

  def feedback(feedback)
    @feedback = feedback
    mail(:subject => t(:'mailers.feedback.subject'))
  end

  # For Users

  def provider_approved(provider)
    @provider = provider
    mail(:from => 'info@kursor.org.ua',:to => @provider.user.email,:subject => t(:'mailers.provider_approved.subject'))
  end

  def tutor_approved(tutor)
    @tutor = tutor
    mail(:from => 'info@kursor.org.ua',:to => @tutor.user.email,:subject => t(:'mailers.tutor_approved.subject'))
  end

  def posting_approved(posting)
    @posting = posting
    mail(:from => 'info@kursor.org.ua',:to => @posting.user.email,:subject => t(:'mailers.posting_approved.subject'))
  end

end
