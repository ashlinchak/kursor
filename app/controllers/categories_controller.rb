class CategoriesController < ApplicationController

  def show
    respond_to do |format|
      format.html
      format.json { render :json => categories }
    end
  end

  private

  def categories
    @categories = if params[:id]
    else
      root_categories
    end
  end
  helper_method :categories

  def category
    @category = if params[:id]
      Category.find_by_permalink(params[:id])
    else
      Category.new(params[:category])
    end
  end
  helper_method :category


end
