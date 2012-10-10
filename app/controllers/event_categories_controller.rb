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
    @events ||= if event_category.root?
      Kaminari.paginate_array(event_category.events.approved).page(params[:page]).per(30)
    else
      Kaminari.paginate_array(event_category.sub_events.approved).page(params[:page]).per(30)
    end
  end
  helper_method :events

end
