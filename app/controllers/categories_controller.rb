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

  def promoted_providers
    promotions_by_provider = Promotion.where(:promotionable_type => 'Provider').current.featured
    @selected_providers ||= if category.root?
       category.providers.where(id: promotions_by_provider.map(&:promotionable_id))
    else
      category.sub_providers.where(id: promotions_by_provider.map(&:promotionable_id))
    end
  end
  helper_method :promoted_providers

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
      addressables = Address::Location.where(
        :city_id => (filtered_cities || filter[:city_id]),
        :addressable_type => ['Filial', 'Provider']
      ).map(&:addressable).compact

      providers = []
      providers_in_category = category.root? ? category.providers.approved : category.sub_providers.approved

      addressables.each do |addressable|
        provider = if addressable.is_a? Filial
          addressable.provider
        elsif addressable.is_a? Provider
          addressable
        end
        if provider &&
          provider.is_approved &&
          (
           ( category == provider.category ) ||
           # make less request to db by comparing from category
           providers_in_category.include?(provider)
          )
          providers << provider
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
