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
    transfer_user.confirm!
    transfer_user.unlock_access!
    if transfer_user.update_attributes(params[:user])
      unless params[:send_email] != 'yes'
        if !params[:additional_message].blank?
          if UserTransferMailer.transfer_email_with_add_msg(transfer_user, transfer_user.password, params[:additional_message]).deliver
            flash[:success] = t(:'admin.transfering_users.success_with_mail_plus_add_msg', :add_msg => params[:additional_message], :email => transfer_user.email.to_s, :password => ( transfer_user.password != '' ? transfer_user.password : t(:'admin.transfering_users.no_changes') )).html_safe
          end
        else
          if UserTransferMailer.transfer_email(transfer_user, transfer_user.password).deliver
            flash[:success] = t(:'admin.transfering_users.success_with_mail', :email => transfer_user.email.to_s, :password => ( transfer_user.password != '' ? transfer_user.password : t(:'admin.transfering_users.no_changes') )).html_safe
          end
        end
      else
        flash[:success] = t(:'admin.transfering_users.success_without_mail', :email => transfer_user.email.to_s, :password => ( transfer_user.password != '' ? transfer_user.password : t(:'admin.transfering_users.no_changes') )).html_safe
      end
      redirect_to edit_admin_user_transfer_path(transfer_user)
    else
      flash[:error] = t('admin.transfering_users.failed').html_safe
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
