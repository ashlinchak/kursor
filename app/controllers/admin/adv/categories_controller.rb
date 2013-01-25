class Admin::Adv::CategoriesController < Admin::DashboardController

  skip_before_filter :set_ads_name

  def index
  end

  def show
  end

  def new
  end

  def create

    #if params[:parent]
    #  if category.save :parent => Adv::Category.find_by_permalink(params[:parent])
    #    flash[:success] = 'Adv category was successfully created.'
    #    redirect_to admin_adv_categories_path
    #  else
    #    render :action => "new"
    #  end
    #else
      if category.save
        flash[:success] = 'Adv category was successfully created.'
        redirect_to admin_adv_categories_path
      else
        render :action => "new"
      end
    #end

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
  end

  def destroy
    unless category.children.exists? #|| category.postings.exist?
      category.destroy
    else
      flash[:error] = 'Can\'t delete non-empty category'
    end
    redirect_to admin_adv_categories_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = Adv::Category.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
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
