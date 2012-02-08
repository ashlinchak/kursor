class ScheduleEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider

  scope :at_day, lambda{|day| where('start_at > ? and start_at < ?', day, day + 1.day) }
end
