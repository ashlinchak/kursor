class ActivationsController < ApplicationController

  def new
  end

  def create
    if user = User.find_by_email(params[:email])
      # create user activation link
      user.generate_activation
      UserActivationMailer.activation_email(user).deliver
      flash[:success] = t(:'user_activation.create.success').html_safe
      redirect_to login_url
    else
      flash[:error] = t(:'user_activation.create.error').html_safe
      redirect_to new_activation_path
    end
  end

  def perform
    if user_activation = UserActivation.find_by_token(params[:id])
      if user = user_activation.user
        user_activation.activate!
        flash[:success] = t(:'user_activation.perform.success').html_safe
        # logging in activated user
        self.current_user = user
        redirect_to user
      else
        flash[:error] = t(:'user_activation.user_not_found').html_safe
        redirect_to root_path
      end
    else
      flash[:error] = t(:'user_activation.not_found').html_safe
      redirect_to :action => :create
    end
  end
end
