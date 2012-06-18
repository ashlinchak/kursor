class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :rateable_type
      t.integer :rateable_id
      t.integer :votes_count, :default => 0
      t.integer :total_value, :default => 0
      t.float :average_value, :default => 0
      t.timestamps
    end
    add_index :ratings, [:rateable_id, :rateable_type]
  end
end
