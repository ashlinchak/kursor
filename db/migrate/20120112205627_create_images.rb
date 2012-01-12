class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :src
      t.string :title
      t.text :description
      t.references :imageable, :polymorphic => true

      t.timestamps
    end
    add_index :images, :imageable_id
  end
end
