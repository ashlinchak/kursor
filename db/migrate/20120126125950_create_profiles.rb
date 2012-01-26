class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.date :birth_date
      t.text :bio
      t.references :user

      t.timestamps
    end
    add_index :profiles, :user_id

    add_column :users, :nickname, :string
  end
end
