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

    #    render :json => City.order(:name).tokens(params[:q]).as_json(:only => [:id, :name], :include => {:region => {:only => :name}})

    render :json => ThinkingSphinx.search(params[:q], :classes => [Provider, Tutor]).as_json( :only => [:name] )

  end

end
