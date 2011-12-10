class AddDescriptionUkToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :description_uk, :text
  end
end
