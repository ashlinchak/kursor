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
      redirect_to admin_provider_categories_path
    else
      render :action => "new"
    end
  end

  def update
    if category.update_attributes(params[:category])
      flash[:success] = 'Category was successfully updated.'
      redirect_to admin_provider_categories_path
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
    redirect_to admin_provider_categories_path
  end

  private

  def categories
    @categories = if params[:id]
    else
      root_provider_categories
    end
  end

  def category
    @category = if params[:id]
      category_type.find_by_permalink(params[:id])
    else
      category_type.new(params[:category])
    end
  end
  helper_method :category


  def category_type
    params[:type].constantize
  end

end
