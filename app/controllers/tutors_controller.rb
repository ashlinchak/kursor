class TutorsController < ApplicationController

  before_filter :require_authentication, :except => [:index, :show]

  def index
  end

  def show
  end

  def new
    tutor.build_location unless tutor.location
  end

  def edit
    tutor.build_location unless tutor.location
  end

  def create
    tutor.user = current_user
    if tutor.save
      flash[:success] = 'Tutor was successfully created.'
      redirect_to tutor_path(tutor)
    else
      render :action => "new"
    end
  end

  def update
    # trick to delete unchecked tutor_categories
    params[:tutor][:tutor_category_ids] ||= []
    if tutor.update_attributes(params[:tutor])
      flash[:notice] = 'Tutor was successfully updated.'
      redirect_to tutor_path(tutor)
    else
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

end
