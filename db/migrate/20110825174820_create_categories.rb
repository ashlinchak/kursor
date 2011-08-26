class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.references :parent, :null => true
      t.string :permalink

      t.timestamps
    end
    add_index :categories, :parent_id
  end
end
