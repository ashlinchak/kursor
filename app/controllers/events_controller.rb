class EventsController < ApplicationController

  inherit_resources

  belongs_to :provider, :tutor, :polymorphic => true, :optional => true

  before_filter :require_authentication, :except => [:index, :show]
  before_filter :require_owner, :only => [ :edit, :update, :destroy ]

private

  def events
    collection
  end
  helper_method :events

  def event
    resource
  end
  helper_method :event

  def event_parent
    parent
  end
  helper_method :event_parent

  def require_owner
    unless current_user.administrator?
      unless current_user == event.eventable.user
        flash[:error] = t('site.errors.access_denied')
        redirect_to root_path
      end
    end
  end

end
