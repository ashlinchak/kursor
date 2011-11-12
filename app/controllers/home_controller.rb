class HomeController < ApplicationController
  def index
  end

  private

  def news
    @news = News.all.reverse
  end
  helper_method :news

  def providers
    @providers = Provider.approved.reverse
  end
  helper_method :providers

end
