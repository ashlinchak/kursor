class Address::Location < ActiveRecord::Base
  include Address
  belongs_to :city
  belongs_to :addressable, :polymorphic => true
end
