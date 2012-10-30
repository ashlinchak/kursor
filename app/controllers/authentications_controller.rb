class AuthenticationsController < ApplicationController
  #def index
    #@authentications = current_user.authentications if current_user
  #end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    flash[:success] = t(:'devise.authentications.flash.successfully_destroyed_authentication', :provider => @authentication.provider.titleize)
    @authentication.destroy
    redirect_to user_path(current_user)
  end
end
