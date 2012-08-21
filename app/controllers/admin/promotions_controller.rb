class Admin::PromotionsController < Admin::DashboardController
  inherit_resources
  #defaults :resource_class => 'Promotion'#, :collection_name => 'cities', :instance_name => 'city'

protected

  def promotions
    collection
  end
  helper_method :promotions

  def promotion
    resource
  end
  helper_method :promotion

end
