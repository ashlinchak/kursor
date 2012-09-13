class CreateMetatags < ActiveRecord::Migration
  def change
    create_table :metatags do |t|
      t.string :title
      t.text :description
      t.text :keywords
      t.text :additional
      t.boolean :split_keywords
      t.integer :metatagable_id
      t.string :metatagable_type

      t.timestamps
    end
    add_index :metatags, :metatagable_id
    add_index :metatags, :metatagable_type
  end
end
