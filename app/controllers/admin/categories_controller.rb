class Admin::CategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render :json => categories }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render :json => categories }
    end
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
