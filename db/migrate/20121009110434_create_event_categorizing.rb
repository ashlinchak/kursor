class CreateEventCategorizing < ActiveRecord::Migration
  def change
    create_table :event_categorizings do |t|
      t.references :event
      t.references :event_category

      t.timestamps
    end
    add_index :event_categorizings, :event_id
    add_index :event_categorizings, :event_category_id
  end
end
