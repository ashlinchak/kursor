class Admin::CitiesController < Admin::DashboardController


  inherit_resources
  defaults :resource_class => Address::City#, :collection_name => 'cities', :instance_name => 'city'

protected

  def regions
    @regions ||= Address::Region.all
  end
  helper_method :regions

  def city
    resource
  end
  helper_method :city

end
