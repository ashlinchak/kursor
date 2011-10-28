class Admin::CategoriesController < ApplicationController
  layout 'admin'

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if category.save
      redirect_to admin_categories_path, :notice => 'Category was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if category.update_attributes(params[:category])
      redirect_to admin_categories_path, :notice => 'Category was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    category.destroy

    redirect_to admin_categories_path
  end

  private

  def categories
    @categories = if params[:id]
    else
      root_categories
    end
  end

  def category
    @category = if params[:id]
      Category.find_by_permalink(params[:id])
    else
      Category.new(params[:category])
    end
  end
  helper_method :category

end
