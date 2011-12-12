class Admin::LocationsController < Admin::DashboardController
  layout 'admin'

  before_filter :require_authorization

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if location.save
      redirect_to admin_categories_path, :notice => 'Location was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if location.update_attributes(params[:location])
      redirect_to admin_categories_path, :notice => 'Location was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    category.destroy

    redirect_to admin_categories_path
  end

  private

  def locations
    @locations ||= Address::Region.all
  end
  helper_method :locations

end
