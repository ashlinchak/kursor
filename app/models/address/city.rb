class Address::City < ActiveRecord::Base
  belongs_to :region, :class_name => 'Address::Region'
  validates :name, :uniqueness => { :scope => :region_id }
end
