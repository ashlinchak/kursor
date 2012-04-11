class Region < ActiveRecord::Base
  include Address
  def self.table_name_prefix
    'address_'
  end
  #belongs_to :country
  #belongs_to :region
  has_many :cities
  has_many :locations, :through => :cities

  validates :name, :uniqueness => true

end
