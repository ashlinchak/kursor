class Adv::CategoriesController < ApplicationController


  def index
  end


  def show

  end


  def adv_category
    @category ||= if params[:id]
      Adv::Category.find_by_permalink(params[:id])
    end
  end
  helper_method :adv_category

  def adv_categories
  	@adv_categories = Adv::Category.roots
  end
  helper_method :adv_categories


  def postings

    if params[:t] == 'demand'
      @postings = adv_category.postings.demand.published
    elsif params[:t] == 'supply'
      @postings = adv_category.postings.supply.published
    else
      @postings = adv_category.postings.published
    end
  end
  helper_method :postings

end
