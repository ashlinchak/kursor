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
    @providers ||= if category.root?
      Kaminari.paginate_array(category.providers).page(params[:page]).per(30)
    else
      Kaminari.paginate_array(category.sub_providers).page(params[:page]).per(30)
    end
  end
  helper_method :providers

end
