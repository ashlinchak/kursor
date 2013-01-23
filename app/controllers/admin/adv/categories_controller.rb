class Admin::Adv::CategoriesController < Admin::DashboardController

  skip_before_filter :set_ads_name

  def index
  end

  def show
  end

  def new
  end

  def create

    if category.save
      flash[:success] = 'Adv category was successfully created.'
      redirect_to admin_adv_categories_path
    else
      render :action => "new"
    end
    #@category = Category.new(params[:category])
    #redirect_to [:admin, :adv, @category], :notice => "Successfully created category."
  end

  def edit
  end

  def update
    if category.update_attributes(params[:adv_category])
      flash[:success] = 'Adv category was successfully updated.'
      redirect_to admin_adv_category_path(category)
    else
      render :action => "edit"
    end
    #redirect_to [:admin, :adv, @category], :notice  => "Successfully updated category."
  end

  def destroy
    unless category.children #|| category.postings.exist?
      category.destroy
    else
      flash[:error] = 'Can\'t delete non-empty category'
    end
    redirect_to admin_adv_categories_path
  end

  def categories
    @categories ||= if params[:id]
                    else
                      Adv::Category.roots
                    end
  end
  helper_method :categories

  def category
    @category ||= if params[:id]
      Adv::Category.find_by_permalink(params[:id])
    else
      Adv::Category.new(params[:adv_category])
    end
  end
  helper_method :category


end
