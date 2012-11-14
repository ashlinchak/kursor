class TutorsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :require_owner, :only => [ :edit, :update, :destroy ]

  def index
  end

  def show
  end

  def new
    if current_user.tutor?
      if current_user.tutor.present?
        flash[:error] = "You have already created tutor profile"
        redirect_to current_user
      else
        tutor.build_location unless tutor.location
      end
    else
      flash[:error] = "You cant create tutor. Because your account is not Tutor"
      redirect_to current_user
    end
  end

  def edit
    tutor.build_location unless tutor.location
  end

  def create
    tutor.user = current_user
    if tutor.save
      flash[:success] = t(:'tutors.create.success').html_safe
      NotificationMailer.tutor_created(tutor).deliver
      redirect_to tutor_path(tutor)
    else
      flash[:error] = (:'tutors.create.error').html_safe
      render :action => "new"
    end
  end

  def update
    # trick to delete unchecked tutor_categories
    params[:tutor][:tutor_category_ids] ||= []
    if tutor.update_attributes(params[:tutor])
      flash[:success] = t(:'tutors.edit.success').html_safe
      redirect_to tutor_path(tutor)
    else
      flash[:error] = t(:'tutors.create.error').html_safe
      render :action => "edit"
    end
  end

  def destroy
    tutor.destroy
    redirect_to tutors_url
  end

  def tutor
    @tutor ||= if params[:id]
      Tutor.find(params[:id])
    else params[:tutor]
      Tutor.new(params[:tutor])
    end
  end
  helper_method :tutor

  def tutors
    @tutors ||= Tutor.all
  end
  helper_method :tutors

  def require_owner
    unless current_user.administrator?
      unless current_user == Tutor.find(params[:id]).user
        #rescue ActiveRecord::RecordNotFound
        flash[:error] = t('site.errors.access_denied')
        redirect_to root_path
      end
    end
  end

end
