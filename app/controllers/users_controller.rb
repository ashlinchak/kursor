class UsersController < ApplicationController

  before_filter :require_authentication, :except => [:new, :create, :show]

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => users }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render :json => user }
    end
  end

  def new
    if authenticated?
      flash[:notice] = 'You already registered and logged in!'
      redirect_to current_user and return
    end
  end

  def edit
  end

  def create
    if user.save
      UserMailer.registration_confirmation(user).deliver
      flash[:success] = t(:'users.flash.user_created').html_safe
      redirect_to user
    else
      render :action => "new"
    end
  end

  def update
    if current_user.update_attributes(params[:user])
        flash[:notice] = t(:'users.flash.user_updated')
        redirect_to current_user
    else
      render :action => "edit"
    end
  end

  def destroy
    user.destroy
    redirect_to root
  end

  def users
    @users ||= User.all
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