class CategoriesController < ApplicationController

  def show
    respond_to do |format|
      format.html
      format.json { render :json => categories }
    end
  end

  private

  def categories
    @categories ||= if params[:id]
      category.children
    else
      root_categories
    end
  end
  helper_method :categories

  def category
    @category ||= if params[:id]
      Category.find_by_permalink!(params[:id])
    else
      Category.new(params[:categories])
    end
  end
  helper_method :category

  def providers
    @providers ||= if ( !filter || filter[:region_id].blank? )
      if category.root?
        Kaminari.paginate_array(category.providers.approved).page(params[:page]).per(30)
      else
        Kaminari.paginate_array(category.sub_providers.approved).page(params[:page]).per(30)
      end
    else
      # Providers filtering by City and Region in current category
      if filter[:city_id].blank?
        filtered_cities = Address::City.where(:region_id => filter[:region_id])
      end
      addressables = Address::Location.where(:city_id => filtered_cities || filter[:city_id]).map(&:addressable).compact

      providers = []

      addressables.each do |addressable|
        provider = if addressable.is_a? Filial
          addressable.provider
        elsif addressable.is_a? Provider
          addressable
        end
        if provider && (provider.categories.include? category || provider.category == category)
          if provider.is_approved
            providers << provider
          end
        end
      end

      providers = providers.compact.uniq

      Kaminari.paginate_array(providers).page(params[:page]).per(30)
    end
  end
  helper_method :providers

  def filter
    @filter ||= params[:filter] || {}
  end
  helper_method :filter
end
