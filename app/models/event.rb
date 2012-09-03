class Event < ActiveRecord::Base

  attr_accessible :description,
                  :end_datetime,
                  #:eventable_id,
                  #:eventable_type,
                  :location_id,
                  :max_price,
                  :min_price,
                  :start_datetime,
                  :teacher,
                  :title,
                  :location_attributes

  after_initialize :build_nested_resources

  belongs_to :eventable, :polymorphic => true

  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location

  validates_presence_of :start_datetime, :title, :description

  default_scope order('start_datetime ASC')

  def build_nested_resources
    self.build_location unless location
  end

end
