class CreateUserActivations < ActiveRecord::Migration
  def change
    create_table :user_activations do |t|
      t.string :token
      t.datetime :expire_at
      t.references :user

      t.timestamps
    end
    add_index :user_activations, :user_id
  end
end
