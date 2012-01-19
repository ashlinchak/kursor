class HomeController < ApplicationController
  def index
  end

  private

  def news
    @news = News.all.reverse
  end
  helper_method :news

  def providers
    @providers = Provider.approved.reverse[0..20]
  end
  helper_method :providers

  def featured_posting
    @featured_posting ||= Posting.last
  end
  helper_method :featured_posting

  def recent_postings
    @recent_postings ||= Posting.recent.reverse
  end

end
