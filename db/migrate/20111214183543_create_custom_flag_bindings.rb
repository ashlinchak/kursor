class CreateCustomFlagBindings < ActiveRecord::Migration
  def change
    create_table :custom_flag_bindings do |t|
      t.references :custom_flag
      t.references :provider
      t.boolean :value, :null => false

      t.timestamps
    end
    add_index :custom_flag_bindings, :custom_flag_id
    add_index :custom_flag_bindings, :provider_id
  end
end
