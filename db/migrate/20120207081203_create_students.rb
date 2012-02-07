class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :user
      t.references :provider
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
    add_index :students, :user_id
    add_index :students, :provider_id
  end
end
