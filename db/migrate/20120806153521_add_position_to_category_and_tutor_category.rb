class AddPositionToCategoryAndTutorCategory < ActiveRecord::Migration
  def change
    add_column :categories, :position, :integer, :default => 0, :null => false
    add_column :tutor_categories, :position, :integer, :default => 0, :null => false
  end
end
