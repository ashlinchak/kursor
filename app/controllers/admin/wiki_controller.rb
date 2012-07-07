class Admin::WikiController < Admin::DashboardController

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if wiki_page.save
      flash[:success] = 'New wiki page was successfully created.'
      redirect_to admin_wiki_index_path
    else
      render :action => "new"
    end
  end

  def update
    if wiki_page.update_attributes(params[:wiki])
      flash[:success] = 'Wiki page was successfully updated.'
      redirect_to admin_wiki_index_path
    else
      render :action => "edit"
    end
  end

  def destroy
    wiki_page.destroy
    flash[:notice] = 'Wiki page was successfully destroyed.'
    redirect_to admin_wiki_index_url
  end

  def wiki_pages
    @wiki_pages ||= Wiki.all
  end
  helper_method :wiki_pages

  def wiki_page
    @wiki_page ||= if params[:id]
      Wiki.find_by_permalink params[:id]
    else
      Wiki.new params[:wiki]
    end
  end
  helper_method :wiki_page

  def roots_wiki_pages
    Wiki.roots
  end
  helper_method :roots_wiki_pages

end
