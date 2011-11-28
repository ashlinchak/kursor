class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :contact_type_id
      t.references :provider
      t.string :value

      t.timestamps
    end
    add_index :contacts, :provider_id
  end
end
