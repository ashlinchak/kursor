class Address::Region < ActiveRecord::Base
  belongs_to :country
  belongs_to :region
end
