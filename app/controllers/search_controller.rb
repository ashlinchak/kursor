class SearchController < ApplicationController

  def index
  end

  def search_results
    @search_results ||=( [] << if params[:q] && !params[:q].blank?
      Provider.search(params[:q])
    end ).flatten.compact
  end
  helper_method :search_results

  def provider_user (provider)
    @provider_user = Provider.find(provider.id).user.id
  end
  helper_method :provider_user

end
