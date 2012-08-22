class AddPositionToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :position, :integer, default: 0, null: false
  end
end
