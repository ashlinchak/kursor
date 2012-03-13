class AddParentAndPermalinkToPostingCategory < ActiveRecord::Migration
  def change

    change_table :posting_categories do |t|

      t.references :parent, :null => true
      t.string :permalink

    end

    add_index :posting_categories, :parent_id

  end
end
