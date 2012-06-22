class Admin::InfoController < Admin::DashboardController

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
      flash[:success] = 'New page was successfully created.'
      redirect_to admin_info_index_path
    else
      render :action => "new"
    end
  end

  def update
    if info_page.update_attributes(params[:info])
      flash[:success] = 'Page was successfully updated.'
      redirect_to admin_info_index_path
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

  def roots_info_pages
    Info.roots
  end
  helper_method :roots_info_pages

end
