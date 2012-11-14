class ProvidersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  before_filter :require_owner, :only => [ :edit, :update, :destroy ]

  def index
    respond_to do |format|
      #format.html
      format.json { render :json => Provider.order(:name) }
    end
  end

  def show
  end

  def new
    if current_user.school?
      if current_user.can_add_provider?
        provider.build_location unless provider.location
        #provider.build_filials unless provider.filials
        #provider.filials.build_location unless provider.filials
      else
        flash[:error] = "You cant create more providers. Update your Plan!"
        redirect_to current_user
      end
    else
      flash[:error] = "You cant create provider. Because your account is not School"
      redirect_to current_user
    end
  end

  def edit
    provider.build_location unless provider.location
  end

  def create
    provider.user = current_user
    if provider.save
      flash[:success] = t(:'providers.create.success').html_safe
      NotificationMailer.provider_created(provider).deliver
      redirect_to provider
    else
      flash[:error] = t(:'providers.create.error').html_safe
      render :action => "new"
    end
  end

  def update
    # trick to delete unchecked provider_categories
    params[:provider][:category_ids] ||= []
    if provider.update_attributes(params[:provider])
      flash[:success] = t(:'providers.edit.success').html_safe
      redirect_to provider_path(provider)
    else
      render :action => "edit"
    end
  end

  def destroy
    provider.destroy
    redirect_to providers_url
  end

  def provider_request

  end

  private

  def provider
    @provider ||= if params[:id]
      Provider.find(params[:id])
    else params[:provider]
      Provider.new(params[:provider])
    end
  end
  helper_method :provider

  def providers
    @providers ||= Provider.all
  end
  helper_method :providers

  def require_owner
    unless current_user.administrator?
      unless current_user == Provider.find(params[:id]).user
        #rescue ActiveRecord::RecordNotFound
        flash[:error] = t('site.errors.access_denied')
        redirect_to root_path
      end
    end
  end

end