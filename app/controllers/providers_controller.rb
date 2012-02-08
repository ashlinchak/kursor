class ProvidersController < ApplicationController

  before_filter :require_authentication, :except => [:index, :show]

  def index
  end

  def show
  end

  def new
    provider.build_location
    provider.build_filials
    provider.filials.build_location
  end

  def edit
    provider.build_location unless provider.location
  end

  def create
    provider.user = current_user
    if provider.save
      flash[:success] = 'Provider was successfully created.'
      redirect_to provider_path(provider.permalink)
    else
      render :action => "new"
    end
  end

  def update
    # trick to delete unchecked categories
    params[:provider][:category_ids] ||= []
    if provider.update_attributes(params[:provider])
      flash[:notice] = 'Provider was successfully updated.'
      redirect_to provider
    else
      render :action => "edit"
    end
  end

  def destroy
    provider.destroy
    redirect_to providers_url
  end

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

end
