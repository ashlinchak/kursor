class AddCustomCityToLocations < ActiveRecord::Migration
  def change
    add_column :address_locations, :custom_city, :string
    add_column :address_locations, :custom_region, :string
  end
end
