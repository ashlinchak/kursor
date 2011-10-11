class SessionsController < ApplicationController
  def new
  end

  def create
    if self.current_user = User.authenticate( params[:user][:email], params[:user][:password] )
      redirect_to root_url, :notice => t(:'sessions.create.success')
    else
      redirect_to login_url, :error => t(:'sessions.create.error')
    end
  end

  def destroy
    current_user = nil
    reset_session
    redirect_to :root, :notice => t(:'sessions.destroy.success')
  end

end
