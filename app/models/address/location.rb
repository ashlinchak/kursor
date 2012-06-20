class Location < ActiveRecord::Base
  include Address
  def self.table_name_prefix
    'address_'
  end

  geocoded_by :full_address

  belongs_to :city
  belongs_to :addressable, :polymorphic => true

  after_validation :geocode, :if => :street_changed? || :building_changed?

  def full_address
    @city = City.find(city_id)
    @request = [street, building, @city.name].compact.join(', ')
    @request
    logger.info @request
  end

end
