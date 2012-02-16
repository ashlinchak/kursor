class CreatePostingCategorizings < ActiveRecord::Migration
  def change
    create_table :posting_categorizings do |t|
      t.references :posting
      t.references :posting_category

      t.timestamps
    end
    add_index :posting_categorizings, :posting_id
    add_index :posting_categorizings, :posting_category_id
  end
end
