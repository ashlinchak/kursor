class Promotion < ActiveRecord::Base
  belongs_to :promotinable, polymorphic: true
  attr_accessible :end_date, :is_featured, :is_vip, :start_date
end
