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
  end

end
