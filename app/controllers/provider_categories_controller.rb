class ProviderCategoriesController < ApplicationController

  def show
    respond_to do |format|
      format.html
      format.json { render :json => categories }
    end
  end

  private

  def provider_categories
    @provider_categories = if params[:id]
    else
      root_provider_categories
    end
  end
  helper_method :provider_categories

  def provider_category
    @provider_category = if params[:id]
      ProviderCategory.find_by_permalink(params[:id])
    else
      ProviderCategory.new(params[:categories])
    end
  end
  helper_method :provider_category

  def providers
    @providers ||= if provider_category.root?
      #category.providers
      Kaminari.paginate_array(provider_category.providers).page(params[:page]).per(30)
    else
      #category.sub_providers
      Kaminari.paginate_array(provider_category.sub_providers).page(params[:page]).per(30)
    end
  end
  helper_method :providers

end
