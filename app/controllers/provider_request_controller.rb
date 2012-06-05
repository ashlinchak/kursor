class ProviderRequestController < ApplicationController

  def new
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
      render :new
    end
  end


end
