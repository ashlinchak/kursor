class Filial < ActiveRecord::Base
  belongs_to :provider
  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location

  has_many :contacts, :as => :contactable, :dependent => :destroy
  accepts_nested_attributes_for :contacts, :reject_if => lambda { |c| c[:value].blank? || c[:contact_type_id].blank? }, :allow_destroy => true

  # TODO: research nested associations building
  def location= attrs
    self.location_attributes= attrs
  end
end
