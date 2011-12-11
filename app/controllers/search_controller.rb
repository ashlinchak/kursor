class SearchController < ApplicationController

  def index
  end

  def search_results
    @search_results ||=( [] << if params[:q] && !params[:q].blank?
      Provider.search(params[:q])
    end ).flatten.compact
  end
  helper_method :search_results

end
