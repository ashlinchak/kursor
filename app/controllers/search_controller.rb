class SearchController < ApplicationController

  def index

  end

  def search_results
    if params[:q].blank?
      @search_results = []
    else
      @search_results = ThinkingSphinx.search params[:q], :classes => [Provider, Tutor, Posting]
    end


  end
  helper_method :search_results

  def auto_complete_search
    Provider.search(params[:q]).to_json
  end

end
