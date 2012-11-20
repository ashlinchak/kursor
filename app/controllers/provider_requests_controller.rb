class ProviderRequestsController < ApplicationController

  def index
    @provider_request = ProviderRequest.new
  end

  def create

    @provider_request = ProviderRequest.new(params[:provider_request])

    if @provider_request.valid? && simple_captcha_valid?
      ProviderRequestMailer.new_request(@provider_request).deliver
      flash[:success] = t(:'provider_request.messages.success')
      redirect_to root_path
    else

      @error_msg = ''

      unless simple_captcha_valid?
        @error_msg += t(:'feedback.messages.failed')
      end

      unless @provider_request.valid?
        @error_msg += t(:'provider_request.messages.failed')
      end

      flash[:error] = ('<ul>'+@error_msg+'</ul>').html_safe
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
