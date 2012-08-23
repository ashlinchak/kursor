class Admin::PromotionsController < Admin::DashboardController
  inherit_resources

  def create
    create!{ [:admin, :promotions] }
  end

  def update
    update!{ [:admin, :promotions] }
  end

protected

  def promotions
    collection.by_position
  end
  helper_method :promotions

  def promotion
    resource
  end
  helper_method :promotion

end
