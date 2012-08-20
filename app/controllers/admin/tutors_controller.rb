class Admin::TutorsController < ApplicationController

  require 'csv'

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

  def export
    @contacts = Contact.where("contactable_type = ? AND contact_type_id = ?", 'Tutor', 1)
    @string = StringIO.new

    @string = CSV.generate do |csv|
      #csv << ['Email', 'Title', 'URL']
      @contacts.each do |contact|
        tut = Tutor.find(contact.contactable_id) if Tutor.find(contact.contactable_id)
        csv << [contact.value, tut.name, tutor_url(tut)]
      end
    end

    respond_to do |format|
      format.html
      format.csv { send_data @string }
    end

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
