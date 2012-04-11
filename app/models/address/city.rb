class City < ActiveRecord::Base
  include Address
  def self.table_name_prefix
    'address_'
  end
  belongs_to :region, :class_name => 'Address::Region'
  validates :name, :uniqueness => { :scope => :region_id }
  has_many :locations

  #def to_s
    #name
  #end
end
