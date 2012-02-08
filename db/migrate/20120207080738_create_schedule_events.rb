class CreateScheduleEvents < ActiveRecord::Migration
  def change
    create_table :schedule_events do |t|
      t.string :title
      t.text :description
      t.references :user
      t.references :provider
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
    add_index :schedule_events, :user_id
    add_index :schedule_events, :provider_id
  end
end
