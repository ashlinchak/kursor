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
    @providers ||= unless params[:search]
      if category.root?
        Kaminari.paginate_array(category.providers.approved).page(params[:page]).per(30)
      else
        Kaminari.paginate_array(category.sub_providers.approved).page(params[:page]).per(30)
      end
    else

    # Providers sorting  by City and Region in current category

    if  !params[:search][:city_id].blank?
      addressables = Location.where(:city_id => params[:search][:city_id]).map(&:addressable)
    else
      filtered_cities = City.where(:region_id => params[:search_region_id])
      addressables = Location.where(:city_id => filtered_cities).map(&:addressable)
    end

      providers = []

      addressables.each do |a|
        if a.is_a? Filial
          if a.provider.categories.include? category or a.provider.category == category
             unless a.provider.is_approved == false
               providers << a.provider
             end
          end
        elsif a.is_a? Provider
          if a.categories.include? category or a.category == category
            unless a.is_approved == false
              providers << a
            end
          end
        end
      end

      if providers.size > 1
      providers.uniq!
      end

      Kaminari.paginate_array(providers).page(params[:page]).per(30)
      end

  end
  helper_method :providers

end
