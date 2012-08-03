class AddGmapsToAddressLocations < ActiveRecord::Migration
  def change
    add_column :address_locations, :gmaps, :boolean
  end
end
