class NewsController < ApplicationController

  def index
    @news = News.all.reverse
  end

  def show
    @news = News.find(params[:id])
  end

end
