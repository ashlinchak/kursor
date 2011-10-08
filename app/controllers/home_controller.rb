class HomeController < ApplicationController
  def index
  end

  private

  def news
    @news = News.all
  end
  helper_method :news

end
