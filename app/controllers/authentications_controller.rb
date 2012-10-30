class AuthenticationsController < ApplicationController
  #def index
    #@authentications = current_user.authentications if current_user
  #end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to user_path(current_user)
  end
end
