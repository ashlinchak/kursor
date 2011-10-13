class ProvidersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    provider.user = current_user
    if provider.save
      redirect_to provider_path(provider.permalink), :notice => 'Provider was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if provider.update_attributes(params[:provider])
      redirect_to provider, :notice => 'Provider was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    provider.destroy
    redirect_to providers_url
  end

  def provider
    @provider = if params[:id]
      Provider.find_by_permalink(params[:id])
    else params[:provider]
      Provider.new(params[:provider])
    end
  end
  helper_method :provider

  def providers
    @providers = Provider.all
  end
  helper_method :providers

end
