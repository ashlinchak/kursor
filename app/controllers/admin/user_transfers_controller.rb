class Admin::UserTransfersController < Admin::DashboardController
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    transfer_user.is_active = true
    if transfer_user.update_attributes(params[:user])
      flash[:success] = 'User saved'
      unless params[:send_email] != 'yes'
        if UserTransferMailer.transfer_email(transfer_user, transfer_user.password).deliver
          flash[:success] += ' and mail sent!'
        end
      else
        flash[:success] += ' without sending mail!'
      end
      redirect_to edit_admin_user_transfer_path(transfer_user)
    else
      flash[:success] = 'Failed!'
      redirect_to edit_admin_user_transfer_path(transfer_user)
    end
  end

  def transfer_user
    @transfer_user ||= User.find(params[:id])
  end
  helper_method :transfer_user

  def count_users
    @count_users ||= User.all.size
  end
  helper_method :count_users



end
