class Admin::PostingCategoriesController < Admin::DashboardController
  def index
  end

  def new
  end

  def create
    if posting_category.save
      flash[:success] = 'Posting category was successfully created.'
      redirect_to admin_posting_categories_path
    else
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
   if posting_category.update_attributes(params[:posting_category])
      flash[:success] = 'Posting category was successfully updated.'
      redirect_to admin_posting_categories_path
    else
      render :action => "edit"
    end
  end

  def destroy
    unless (posting_category.children.size > 0) || (posting_category.postings.size > 0)
      posting_category.destroy
    else
      flash[:error] = 'Can\'t delete category! It\'s not empty!'
    end
    redirect_to admin_posting_categories_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = ::PostingCategory.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  private

  def posting_categories
    @posting_categories = if params[:id]
    else
      root_posting_categories
    end
  end
  helper_method :posting_categories

  def posting_category
    @posting_category ||= if params[:id]
      PostingCategory.find_by_permalink params[:id]
    else
      PostingCategory.new params[:posting_category]
    end
  end
  helper_method :posting_category
end
