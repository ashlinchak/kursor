class AddImageToWiki < ActiveRecord::Migration
  def change
    add_column :wikis, :image, :string
  end
end
