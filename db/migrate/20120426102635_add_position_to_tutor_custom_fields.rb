class AddPositionToTutorCustomFields < ActiveRecord::Migration
  def change
    add_column :tutor_custom_fields, :position, :integer, :default => 0, :null => false
  end
end
