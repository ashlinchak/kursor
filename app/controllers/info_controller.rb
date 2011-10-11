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

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => info_page }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if info_page.save
        format.html { redirect_to info_page, :notice => 'Info was successfully created.' }
        format.json { render :json => info_page, :status => :created, :location => info_page }
      else
        format.html { render :action => "new" }
        format.json { render :json => info_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if info_page.update_attributes(params[:info])
        format.html { redirect_to info_page, :notice => 'Info was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => info_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    info_page.destroy
    respond_to do |format|
      format.html { redirect_to infos_url }
      format.json { head :ok }
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
