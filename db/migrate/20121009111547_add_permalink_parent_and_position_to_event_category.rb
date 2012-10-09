class AddPermalinkParentAndPositionToEventCategory < ActiveRecord::Migration
  def change
    change_table :event_categories do |t|
      t.references :parent, :null => true
      t.string :permalink
      t.integer :position, :default => 0, :null => false
    end
    add_index :event_categories, :parent_id
  end
end
