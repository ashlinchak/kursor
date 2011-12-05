class Filial < ActiveRecord::Base
  belongs_to :provider
  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location

  # TODO: research nested associations building
  def address_location= attrs
    self.location_attributes= attrs
  end
end
