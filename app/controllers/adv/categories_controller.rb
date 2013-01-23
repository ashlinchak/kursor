class Adv::CategoriesController < ApplicationController
  def index
    @adv_categories = Adv::Category.all
  end

  def show
    @adv_category = Adv::Category.find(params[:id])
  end
end
