class Admin::ProvidersController < Admin::DashboardController

  def approve
    if provider.approve!
      flash[:success]= t('providers.actions.approve.success', :provider_name => provider.name, :provider_path => provider_path(provider)).html_safe
    else
      flash[:danger]= t(:'providers.approve.error')
    end
    redirect_to admin_notifications_path
  end

  def decline
    if provider.decline!
      flash[:success]= t(:'providers.decline.success')
    else
      flash[:danger]= t(:'providers.decline.error')
    end
    redirect_to admin_notifications_path
  end

  def provider
    @provider ||= if params[:id]
      Provider.find(params[:id])
    else params[:provider]
    Provider.new(params[:provider])
    end
  end
  helper_method :provider

end

