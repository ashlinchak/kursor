class Admin::TutorsController < ApplicationController

  def approve
    if tutor.approve!
      flash[:success]= t('tutors.actions.approve.success', :tutor_name => tutor.name, :tutor_path => tutor_path(tutor)).html_safe
      NotificationMailer.tutor_approved(tutor).deliver
    else
      flash[:danger]= t(:'tutor.approve.error')
    end
    redirect_to admin_notifications_path
  end

  def decline
    if tutor.decline!
      flash[:success]= t(:'tutor.decline.success')
    else
      flash[:danger]= t(:'tutor.decline.error')
    end
    redirect_to admin_notifications_path
  end

  def tutor
    @tutor ||= if params[:id]
       Tutor.find(params[:id])
     else params[:tutor]
     Tutor.new(params[:tutor])
     end
  end
  helper_method :tutor

end
