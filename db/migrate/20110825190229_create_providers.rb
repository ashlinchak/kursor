class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.text :description
      t.references :category
      t.string :permalink

      t.timestamps
    end
    add_index :providers, :category_id
  end
end
