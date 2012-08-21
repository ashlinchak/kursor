class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :eventable_id
      t.string :eventable_type
      t.integer :location_id
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.integer :min_price
      t.integer :max_price
      t.string :teacher

      t.timestamps
    end
  end
end
