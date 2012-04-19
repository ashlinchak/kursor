class CreateTutorCategorizings < ActiveRecord::Migration
  def change
    create_table :tutor_categorizings do |t|
      t.references :tutor_category
      t.references :tutor

      t.timestamps
    end
    add_index :tutor_categorizings, :tutor_category_id
    add_index :tutor_categorizings, :tutor_id
  end
end
