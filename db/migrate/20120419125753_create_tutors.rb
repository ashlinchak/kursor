class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :name
      t.text :description
      t.references :tutor_category
      t.string :permalink

      t.timestamps
    end
    add_index :tutors, :tutor_category_id
  end
end
