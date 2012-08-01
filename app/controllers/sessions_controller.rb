class SessionsController < ApplicationController

  skip_before_filter :require_authentication, :only => [:new, :create]

  def new
  end

  def create
    if user = User.authenticate( params[:user][:email], params[:user][:password] )
      # need to check if user account is activated through email
      if user.is_active?

        self.current_user = user
        flash[:success] = t(:'sessions.create.success')

        if user.tutor? && user.tutor.present?
          redirect_to tutor_path(user.tutor)
        elsif user.school? && user.provider.present?
          redirect_to provider_path(user.provider)
        elsif user.visitor? && user.profile.present?
          redirect_to profile_path(user.profile)
        else
          redirect_to user_path(user)
        end

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
    flash[:success] = t(:'sessions.destroy.success')
    redirect_to :root
  end

end
