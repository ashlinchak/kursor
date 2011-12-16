class SessionsController < ApplicationController

  layout 'login'
  skip_before_filter :require_authentication, :only => [:new, :create]

  def new
  end

  def create
    if user = User.authenticate( params[:user][:email], params[:user][:password] )
      # need to check if user account is activated through email
      if user.is_active?
        self.current_user = user
        redirect_to root_url, :notice => t(:'sessions.create.success')
      else
        flash[:error] = t(:'user_activation.errors.user_inactive')
        redirect_to login_url
      end
    else
      flash[:error] = t(:'sessions.create.error')
      redirect_to login_url
    end
  end

  def destroy
    self.current_user = nil
    reset_session
    redirect_to :root, :notice => t(:'sessions.destroy.success')
  end

end
