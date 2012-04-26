class CreateTutorCustomFieldBindings < ActiveRecord::Migration
  def change
    create_table :tutor_custom_field_bindings do |t|
      t.references :tutor_custom_field
      t.references :tutor
      t.string :value

      t.timestamps
    end
    add_index :tutor_custom_field_bindings, :tutor_custom_field_id
    add_index :tutor_custom_field_bindings, :tutor_id
  end
end
