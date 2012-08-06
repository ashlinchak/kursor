class AddPositionToPostingCategory < ActiveRecord::Migration
  def change
    add_column :posting_categories, :position, :integer, :default => 0, :null => false
  end
end
