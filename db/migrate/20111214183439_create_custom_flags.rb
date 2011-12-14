class CreateCustomFlags < ActiveRecord::Migration
  def change
    create_table :custom_flags do |t|
      t.string :name

      t.timestamps
    end
  end
end
