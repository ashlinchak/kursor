class CategoriesController < ApplicationController
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
      redirect_to category, :notice => 'Category was successfully created.'
    else
      render :action => "new"
    end
    p "category.errors #{category.errors.inspect}"
  end

  def update
    if category.update_attributes(params[:category])
      redirect_to @category, :notice => 'Category was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    category.destroy

    redirect_to categories_url
  end

  private

  def category
    @category = if params[:id]
      Category.find_by_permalink(params[:id])
    else
      Category.new(params[:category])
    end
  end
  helper_method :category


end
