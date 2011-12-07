class Admin::InfoController < ApplicationController
  layout 'admin'

  before_filter :require_authorization

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if info_page.save
      redirect_to info_page, :notice => 'Info was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if info_page.update_attributes(params[:info])
      redirect_to info_page, :notice => 'Info was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    info_page.destroy
    redirect_to admin_infos_url
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
