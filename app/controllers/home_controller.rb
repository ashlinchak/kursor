class HomeController < ApplicationController
  def index
  end

  private

  def news
    @news = News.all.reverse
  end
  helper_method :news

  def providers
    @providers = Provider.all.reverse
  end
  helper_method :providers

end
