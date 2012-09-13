class Admin::CategoriesController < Admin::DashboardController

  def index
  end

  def show
  end

  def new
    category.build_metatag
  end

  def edit
    category.build_metatag# unless category.metatag
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
      redirect_to admin_category_path(category)
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

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = ::Category.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
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
