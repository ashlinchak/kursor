class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :description
      t.text :body
      t.string :permalink
      t.integer :parent_id
      t.timestamps
    end
  end
end