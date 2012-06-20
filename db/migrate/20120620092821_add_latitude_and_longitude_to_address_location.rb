class AddLatitudeAndLongitudeToAddressLocation < ActiveRecord::Migration
  def change
    add_column :address_locations, :latitude, :float
    add_column :address_locations, :longitude, :float
  end
end