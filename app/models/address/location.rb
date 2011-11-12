class Address::Location < ActiveRecord::Base
  belongs_to :city
  belongs_to :addressable
end
