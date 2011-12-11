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
      flash[:notice] = 'Info was successfully created.'
      redirect_to admin_info_path(info_page)
    else
      render :action => "new"
    end
  end

  def update
    if info_page.update_attributes(params[:info])
      flash[:notice] = 'Info was successfully updated.'
      redirect_to admin_info_path(info_page)
    else
      render :action => "edit"
    end
  end

  def destroy
    info_page.destroy
    flash[:notice] = 'Info was successfully destroyed.'
    redirect_to admin_info_index_url
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
