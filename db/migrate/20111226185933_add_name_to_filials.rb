class AddNameToFilials < ActiveRecord::Migration
  def change
    add_column :filials, :name, :string
  end
end
