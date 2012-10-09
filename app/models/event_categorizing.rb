class EventCategorizing < ActiveRecord::Base
  belongs_to :event
  belongs_to :event_category

  def to_s
    event_category
  end
end
