class HomeController < ApplicationController
  def index
  end

  private

  def news
    @news = News.recent
  end
  helper_method :news

  def providers
    @providers = Provider.approved.top_rated
  end
  helper_method :providers

  def featured_posting
    @featured_posting ||= Posting.last
  end
  helper_method :featured_posting

  def recent_postings
    @recent_postings ||= Posting.recent
  end

end
