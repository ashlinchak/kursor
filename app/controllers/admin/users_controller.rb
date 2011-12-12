class Admin::UsersController < Admin::DashboardController

  def index
  end

  def new
    user.build_provider
    user.provider.build_location
  end

  def create
    if user.save
      UserMailer.registration_confirmation(user).deliver
      redirect_to admin_users_path, :notice => t(:'admin.users.create.success')
    else
      render :new
    end
  end

  def edit
    user.build_provider unless user.provider
    user.provider.build_location unless user.provider.location
  end

  def update
    # trick to delete unchecked categories
    params[:user][:provider_attributes][:category_ids] ||= []
    if user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => t(:'admin.users.update.success')
    else
      render :edit
    end
  end

  def destroy
    if user.destroy
      flash[:notice] = t(:'admin.users.destroy.success')
    else
      flash[:notice] = 'Error...'
    end
    redirect_to admin_users_path
  end

  def users
    @users ||= User.page params[:page]
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
