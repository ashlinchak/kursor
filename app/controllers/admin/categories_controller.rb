class Admin::CategoriesController < Admin::DashboardController

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
      flash[:success] = 'category was successfully created.'
      redirect_to admin_categories_path
    else
      render :action => "new"
    end
  end

  def update
    if category.update_attributes(params[:category])
      flash[:success] = 'Category was successfully updated.'
      redirect_to admin_categories_path
    else
      render :action => "edit"
    end
  end

  def destroy
    unless (category.children.size > 0) || (category.providers.size > 0)
      category.destroy
    else
      flash[:error] = 'Can\'t delete non-empty category'
    end
    redirect_to admin_categories_path
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
