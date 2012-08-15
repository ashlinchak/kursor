module Address
  class Region < ActiveRecord::Base
    has_many :cities, :class_name => 'Address::City'
    has_many :locations, :through => :cities, :class_name => 'Address::Location'

    validates :name, :uniqueness => true

  end
end
