class WikiController < ApplicationController

  def index
  end

  def show
  end

  def wiki_pages
    @wiki_pages ||= Wiki.all
  end
  helper_method :wiki_pages

  def wiki_page
    @wiki_page ||= if params[:id]
      Wiki.find_by_permalink! params[:id]
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
