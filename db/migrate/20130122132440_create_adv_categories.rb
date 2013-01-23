class CreateAdvCategories < ActiveRecord::Migration
  def self.up
    create_table :adv_categories do |t|
      t.string :name
      t.string :permalink
      t.text :description
      t.string :ancestry
      t.timestamps
    end
    add_index :adv_categories, :ancestry
  end

  def self.down
    drop_table :adv_categories
  end
end
