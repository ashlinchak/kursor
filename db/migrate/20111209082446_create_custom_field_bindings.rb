class CreateCustomFieldBindings < ActiveRecord::Migration
  def change
    create_table :custom_field_bindings do |t|
      t.references :custom_field
      t.references :provider
      t.string :value

      t.timestamps
    end
    add_index :custom_field_bindings, :custom_field_id
    add_index :custom_field_bindings, :provider_id
  end
end
