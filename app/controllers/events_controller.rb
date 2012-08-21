class EventsController < ApplicationController

 inherit_resources

 before_filter :require_authentication, :except => [:index, :show]

 before_filter :require_owner, :only => [ :edit, :update, :destroy ]

 def events
   @events = Event.all
 end
 helper_method :events

 def event
   resource
 end
 helper_method :event

 def provider
   @provider ||= Provider.find params[:provider_id] if params[:provider_id]
 end
 helper_method :provider

 def tutor
   @tutor ||= Tutor.find params[:tutor_id] if params[:tutor_id]
 end
 helper_method :tutor

 def event_parent
   parent
 end
 helper_method :event_parent


 def require_owner
   unless current_user.administrator?
     unless current_user == event.user
       flash[:error] = t('site.errors.access_denied')
       redirect_to root_path
     end
   end
 end

end
