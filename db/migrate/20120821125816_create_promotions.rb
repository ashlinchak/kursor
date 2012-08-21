class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :promotionable, :polymorphic => true
      t.boolean :is_featured
      t.boolean :is_vip

      t.timestamps
    end
    add_index :promotions, :promotionable_id
    add_index :promotions, :promotionable_type
  end
end
