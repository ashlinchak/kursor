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
    @adv_postings = category.postings
  end
  helper_method :postings

end
