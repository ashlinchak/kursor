class ProfilesController < ApplicationController

  before_filter :require_authentication, :except => [:index, :show]

  before_filter :require_owner, :only => [ :edit, :update, :destroy ]

  def my_profile
    redirect_to profile_path( current_user.profile )
  end

  def index
  end

  def show
  end

  def new
    profile.build_location
  end

  def edit
    profile.build_location unless profile.location
  end

  def create
    profile.user = current_user
    if profile.save
      if params[:profile][:avatar].present?
        render :crop
      else
      flash[:success] = t(:'tutors.create.success').html_safe
      NotificationMailer.profile_created(profile).deliver
      redirect_to profile_path(profile)
      end
    else
      flash[:error] = t(:'tutors.create.error').html_safe
      render :new
    end
  end

  def update
    if profile.update_attributes(params[:profile])
      if params[:profile][:avatar]
        render :crop
      else
        flash[:success] = t(:'tutors.edit.success').html_safe
        redirect_to profile_path(profile)
      end
    else
      flash[:error] = t(:'tutors.edit.error').html_safe
      render :new
    end
  end

  def destroy
    profile.destroy
    redirect_to profiles_url
  end

  def profile
    @profile ||= if params[:id]
      Profile.find(params[:id])
    else params[:profile]
      Profile.new(params[:profile])
    end
  end
  helper_method :profile

  def profiles
    @profiles ||= Profile.all
  end
  helper_method :profiles

  def require_owner
    unless current_user.administrator?
      unless current_user == Profile.find(params[:id]).user
        #rescue ActiveRecord::RecordNotFound
        flash[:error] = t('site.errors.access_denied')
        redirect_to root_path
      end
    end
  end

end