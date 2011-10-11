class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :title
      t.text :body
      t.string :permalink
      t.integer :parent_id

      t.timestamps
    end
  end
end
