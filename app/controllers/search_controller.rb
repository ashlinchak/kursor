class SearchController < ApplicationController

  def index
  end

  def redirect_to_result
    if params[:q]
      if params[:q].blank?
        redirect_to search_index_path
      else
        @id, @class = params[:q].split('-')
        if @class == 'provider'
          redirect_to provider_path(@id)
        elsif 'tutor'
          redirect_to tutor_path(@id)
        end
      end
    else
      flash[:error] = "Can't redirect without parameter!"
      redirect_to :root
    end
  end

  def search_results
    if params[:q].blank?
      @search_results = []
    else
      if params[:t]
        if params[:t] == 'all'
          @search_results = ThinkingSphinx.search params[:q], :classes => [Provider, Tutor, Posting]
        elsif params[:t] == 'prov'
          @search_results = Provider.search params[:q]
        elsif params[:t] == 'tut'
          @search_results = Tutor.search params[:q]
        elsif params[:t] == 'post'
          @search_results = Posting.search params[:q]
        end
      else
        @search_results = ThinkingSphinx.search params[:q], :classes => [Provider, Tutor, Posting]
      end
    end
  end
  helper_method :search_results

  def auto_complete_search
    #render :json => City.order(:name).tokens(params[:q]).as_json(:only => [:id, :name], :include => {:region => {:only => :name}})
    render :json => ThinkingSphinx.search(params[:q], :classes => [Provider, Tutor]).as_json( :only => [:name], :methods => [:composed_id] )
  end

end
