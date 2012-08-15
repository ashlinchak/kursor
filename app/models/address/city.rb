module Address
  class City < ActiveRecord::Base
    belongs_to :region, :class_name => 'Address::Region'
    has_many :locations, :class_name => 'Address::Location'

    validates :name, :uniqueness => { :scope => :region_id }

  end
end
