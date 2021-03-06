module Address
  class Location < ActiveRecord::Base

    belongs_to :city, :class_name => 'Address::City'
    belongs_to :addressable, :polymorphic => true

    acts_as_gmappable :msg => I18n.t(:'address.gmaps_error'), :validation => true

    def gmaps4rails_address
      country = I18n.t(:'address.ukraine')
      #"#{@country}, #{self.city.region.name}, #{self.city.name}, #{self.street}, #{self.building}"
      #"#{@country}, #{self.city.name}, #{self.street}, #{self.building}"
      addr = [country]
      addr << city.name if city
      addr << street unless street.blank?
      addr << building unless building.blank?
      addr.compact!
      return addr.join(' ,')
    end

  end
end
