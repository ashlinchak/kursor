class CreatePostingCategories < ActiveRecord::Migration
  def change
    create_table :posting_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
