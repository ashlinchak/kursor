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
      redirect_to admin_locations_path, :notice => 'Location was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if location.update_attributes(params[:location])
      redirect_to admin_location_path, :notice => 'Location was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    category.destroy

    redirect_to admin_locations_path
  end

  def locations
    @locations ||= Address::Region.all
  end
  helper_method :locations

  def location
    @location ||= if params[:id]
      Address::City.find params[:id]
    else
      Address::City.new params[:location]
    end
  end
  helper_method :location

end
