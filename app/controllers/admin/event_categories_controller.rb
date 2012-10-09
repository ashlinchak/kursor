class Admin::EventCategoriesController < Admin::DashboardController
  def index
  end

  def new
  end

  def create
    if event_category.save
      flash[:success] = 'Event category was successfully created.'
      redirect_to admin_event_categories_path
    else
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
   if event_category.update_attributes(params[:event_category])
      flash[:success] = 'Event category was successfully updated.'
      redirect_to admin_event_categories_path
    else
      render :action => "edit"
    end
  end

  def destroy
    unless (event_category.children.size > 0) || (event_category.events.size > 0)
      event_category.destroy
    else
      flash[:error] = 'Can\'t delete event category! It\'s not empty!'
    end
    redirect_to admin_event_categories_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = ::EventCategory.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  private

  def event_categories
    @event_categories = if params[:id]
    else
      root_event_categories
    end
  end
  helper_method :event_categories

  def event_category
    @event_category ||= if params[:id]
      EventCategory.find_by_permalink params[:id]
    else
      EventCategory.new params[:event_category]
    end
  end
  helper_method :event_category
end
