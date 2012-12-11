class SearchController < ApplicationController

  def index

  end

  def show
    @providers = Provider.search params[:search][:q]
  end

  def auto_complete_search
    Provider.search(params[:q]).to_json
  end

end
