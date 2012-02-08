class ScheduleController < ApplicationController
  def index
  end

  def new
  end

  def create
    if schedule_event.save
      redirect_to user_schedule_path(user)
    else
      render :new
    end
  end

  def show

  end

  def update
  end

  def destroy
    schedule_event.destroy
    redirect_to :back
  end

  def schedule_events
    @schedule_events ||= user.schedule_events
  end
  helper_method :schedule_events

  def schedule_event
    @schedule_event ||= if params[:id]
      user.schedule_events.find params[:id]
    else
      ScheduleEvent.new params[:schedule_event]
    end
  end
  helper_method :schedule_event

  def user
    @user ||= if params[:user_id]
      User.find params[:user_id]
    end
  end
  helper_method :user
end
