class InfoController < ApplicationController

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => info_pages }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => info_page }
    end
  end

  def info_pages
    @info_pages ||= Info.all
  end
  helper_method :info_pages

  def info_page
    @info_page ||= if params[:id]
      Info.find_by_permalink params[:id]
    else
      Info.new params[:info]
    end
  end
  helper_method :info_page

end
