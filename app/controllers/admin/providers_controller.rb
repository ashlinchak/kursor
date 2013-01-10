class Admin::ProvidersController < Admin::DashboardController

  require 'csv'

  def approve
    if provider.approve!
      flash[:success]= t('providers.actions.approve.success', :provider_name => provider.name, :provider_path => provider_path(provider)).html_safe
      NotificationMailer.provider_approved(provider).deliver
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

  def destroy
    if provider.destroy
      flash[:notice] = t(:'admin.providers.destroy.success')
    else
      flash[:notice] = 'Error...'
    end
    redirect_to admin_path
  end

  def destroy_filials
    if provider.destroy_filials!
      flash[:success]= "Filials successfully destroyed."
    else
      flash[:danger]= "There was an error! Can't destroy filials."
    end
    redirect_to admin_filials_path
  end

  def export
    @contacts = Contact.where("contactable_type = ? AND contact_type_id = ?", 'Provider', 1)
    @string = StringIO.new

    @string = CSV.generate do |csv|
      #csv << ['Email', 'Title', 'URL']
      @contacts.each do |contact|
         prov = Provider.find(contact.contactable_id)
         csv << [contact.value, prov.name, provider_url(prov)]
      end
    end

    respond_to do |format|
      format.html
      format.csv { send_data @string }
    end

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

