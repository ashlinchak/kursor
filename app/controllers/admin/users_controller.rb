class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :require_authorization

  def index
  end

  def new
    user.build_provider unless user.provider
  end

  def create
    if user.save
      redirect_to admin_users_path, :notice => 'Done!'
    else
      render :new
    end
  end

  def edit
    user.build_provider unless user.provider
  end

  def update
    if user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => 'Done!'
    else
      render :edit
    end
  end

  def destroy
    if user.destroy
      flash[:notice] = 'Done!'
    else
      flash[:notice] = 'Error...'
    end
    redirect_to admin_users_path
  end

  def users
    @users ||= User.all.reverse
  end
  helper_method :users

  def user
    @user ||= if params[:id]
      User.find params[:id]
    else
      User.new params[:user]
    end
  end
  helper_method :user
end
