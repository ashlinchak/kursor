class Event < ActiveRecord::Base

  attr_accessible :description, :end_datetime, :eventable_id, :eventable_type, :location_id, :max_price, :min_price, :start_datetime, :teacher, :title

  #belongs_to :eventable, :polymorphic => true


  belongs_to :provider, :polymorphic => true
  belongs_to :tutor, :polymorphic => true

  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location



end
