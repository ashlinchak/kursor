class CreateTutorCustomFields < ActiveRecord::Migration
  def change
    create_table :tutor_custom_fields do |t|
      t.string :name

      t.timestamps
    end
  end
end
