class CreateFilials < ActiveRecord::Migration
  def change
    create_table :filials do |t|
      t.references :provider

      t.timestamps
    end
    add_index :filials, :provider_id
  end
end
