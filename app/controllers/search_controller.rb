class SearchController < ApplicationController

  ThinkingSphinx::Configuration::Defaults::PANES << ThinkingSphinx::Panes::ExcerptsPane

  def index

    @tutor_search_count = Tutor.search_count params[:q], :star => true
    @provider_search_count = Provider.search_count params[:q], :star => true
    @posting_search_count = Posting.search_count params[:q], :star => true
    @event_search_count = Event.search_count params[:q], :star => true
    @tag_search_count = Tag.search_count params[:q], :star => true

  end

  def search_results
    if params[:q].blank?
      @search_results = []
    else
      if params[:t]
        if params[:t] == 'all'
          @search_results = ThinkingSphinx.search params[:q], :classes => [Provider, Tutor, Posting, Event, Tag], :star => true, :page => params[:page], :per_page => 15
        elsif params[:t] == 'prov'
          @search_results = Provider.search params[:q], :star => true, :page => params[:page], :per_page => 15
        elsif params[:t] == 'tut'
          @search_results = Tutor.search params[:q], :star => true, :page => params[:page], :per_page => 15
        elsif params[:t] == 'post'
          @search_results = Posting.search params[:q], :star => true, :page => params[:page], :per_page => 15
        elsif params[:t] == 'event'
          @search_results = Event.search params[:q], :star => true, :page => params[:page], :per_page => 15
        elsif params[:t] == 'tag'
          @search_results = Tag.search params[:q], :star => true, :page => params[:page], :per_page => 100
        end
      else
        @search_results = ThinkingSphinx.search params[:q], :classes => [Provider, Tutor, Posting, Event, Tag], :star => true, :page => params[:page], :per_page => 15
      end
    end
  end
  helper_method :search_results

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

  def auto_complete_search
    #render :json => ThinkingSphinx.search(params[:q], :classes => [Provider, Tutor]).as_json( :only => [:name], :methods => [:composed_id] )
    render :json => Provider.search(params[:q]).as_json( :only => [:name], :methods => [:composed_id] )
  end

end
