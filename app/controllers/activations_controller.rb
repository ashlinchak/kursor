class ActivationsController < ApplicationController

  def new
  end

  def create
    if user = User.find_by_email(params[:email])
      # delete pending activation
      #user.user_activation.destroy
      # create user activation link
      user.generate_activation
      UserActivationMailer.activation_email(user).deliver
      flash[:success] = t(:'user_activation.create.success')
      redirect_to login_url
    else
      flash[:error] = t(:'user_activation.create.error')
      redirect_to new_activation_path
    end
  end

  def perform
    if user_activation = UserActivation.find_by_token( params[:id] )
      if user = user_activation.user
        user.is_active = true
        user.save
        flash[:success] = t(:'user_activation.perform.success')
        redirect_to user
      end
      flash[:error] = t(:'user_activation.user_not_found')
      redirect_to root_path
    else
      flash[:error] = t(:'user_activation.not_found')
      redirect_to :action => :create
    end

  end

end
