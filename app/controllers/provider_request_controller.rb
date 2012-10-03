class ProviderRequestController < ApplicationController

  def index
    @provider_request = ProviderRequest.new
  end

  def create

    @provider_request = ProviderRequest.new(params[:provider_request])

    if @provider_request.valid?
      ProviderRequestMailer.new_request(@provider_request).deliver
      flash[:success] = t(:'provider_request.messages.success')
      redirect_to root_path
    else
      flash[:error] = t(:'provider_request.messages.failed').html_safe
      render :index
    end
  end


  private

  def provider
    @provider ||= if params[:provider_id]
                    Provider.find(params[:provider_id])
                  end
  end
  helper_method :provider

end
