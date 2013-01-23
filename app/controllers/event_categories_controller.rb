class EventCategoriesController < ApplicationController

  def index
  end

  def show
  end

  private

  def event_categories
    @event_categories = if params[:id]
    else
      root_event_categories
    end
  end
  helper_method :event_categories

  def event_category
    @event_category = if params[:id]
      EventCategory.find_by_permalink(params[:id])
    else
      EventCategory.new(params[:event_category])
    end
  end
  helper_method :event_category

  def events
    @events ||= if event_category.new_record?
      Kaminari.paginate_array(Event.upcoming).page(params[:page])
    else
      Kaminari.paginate_array(event_category.sub_events.upcoming).page(params[:page])
    end
  end
  helper_method :events

end
