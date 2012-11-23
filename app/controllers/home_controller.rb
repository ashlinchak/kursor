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
    @featured_posting ||= Posting.published.approved.last
  end
  helper_method :featured_posting

  def recent_postings
    @recent_postings ||= Posting.published.approved.recent
  end

  def posting_categories
    @posting_categories ||= if params[:id]
                          else
                            root_posting_categories
                          end
  end
  helper_method :posting_categories

  def home_promotions
    @home_promotions ||= Promotion.current.vip.by_position
  end
  helper_method :home_promotions

end
