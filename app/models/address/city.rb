class Address::City < ActiveRecord::Base
  belongs_to :region
end
