class AddIndexesToCategories < ActiveRecord::Migration
  def change
    add_index :categories, :permalink
  end
end
