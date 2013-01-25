class AddPositionToAdvCategories < ActiveRecord::Migration
  def change
    add_column :adv_categories, :position, :integer, default: 0, null: false
  end
end
