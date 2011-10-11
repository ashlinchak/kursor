class HomeController < ApplicationController
  def index
  end

  private

  def news
    @news = News.all.reverse
  end
  helper_method :news

end
