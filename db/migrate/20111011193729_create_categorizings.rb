class CreateCategorizings < ActiveRecord::Migration
  def change
    create_table :categorizings do |t|
      t.references :category
      t.references :provider

      t.timestamps
    end
    add_index :categorizings, :category_id
    add_index :categorizings, :provider_id
  end
end
