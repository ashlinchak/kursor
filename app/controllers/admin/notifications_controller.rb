class Admin::NotificationsController < Admin::DashboardController


  def index
  end


  def providers_pending
    @providers_pending = Provider.where(:is_approved => false)
  end
  helper_method :providers_pending

  def tutors_pending
    @tutors_pending = Tutor.where(:is_approved => false)
  end
  helper_method :tutors_pending

  def postings_pending
    @posting = Posting.where(:is_approved => false)
  end
  helper_method :postings_pending


end
