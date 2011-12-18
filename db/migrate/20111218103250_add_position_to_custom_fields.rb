class AddPositionToCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :position, :integer, :default => 0, :null => false
    add_column :custom_flags, :position, :integer, :default => 0, :null => false
  end
end
