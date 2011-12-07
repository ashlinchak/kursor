class InfoController < ApplicationController

  def index
  end

  def show
  end

  def info_pages
    @info_pages ||= Info.all
  end
  helper_method :info_pages

  def info_page
    @info_page ||= if params[:id]
      Info.find_by_permalink! params[:id]
    else
      Info.new params[:info]
    end
  end
  helper_method :info_page

end
