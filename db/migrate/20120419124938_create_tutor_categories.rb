class CreateTutorCategories < ActiveRecord::Migration
  def change
    create_table :tutor_categories do |t|
      t.string :name
      t.text :description
      t.references :parent, :null => true
      t.string :permalink
      t.integer :tutors_count, :default => 0
      t.timestamps
    end
    add_index :tutor_categories, :parent_id
  end
end
