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
        Kaminari.paginate_array(category.providers).page(params[:page]).per(30)
      else
        Kaminari.paginate_array(category.sub_providers).page(params[:page]).per(30)
      end
    else


    # Providers sorting  by City and Region in current category

      addressables = Location.where(:city_id => params[:search][:city_id]).map(&:addressable)

      #addressables = Location.where("city_id = :city_id OR region_id = :region_id",{:city_id => params[:search][:city_id], :region_id => params[:search_region_id]}).map(&:addressable)

      providers = []

      addressables.each do |a|
        if a.is_a? Filial
          if a.provider.categories.include? category or a.provider.category == category
            providers << a.provider
          end
        elsif a.is_a? Provider
          if a.categories.include? category or a.category == category
            providers << a
          end
        elsif a.is_a? Profile
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
