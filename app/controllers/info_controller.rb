class InfoController < ApplicationController

  def index
  end

  def show
  end

  def authors
    @admins = Administrator.all
    @authors = @admins.collect{|a| a.user}
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

  def roots_info_pages
    Info.roots
  end
  helper_method :roots_info_pages

end
