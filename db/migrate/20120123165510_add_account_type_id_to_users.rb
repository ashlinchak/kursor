class AddAccountTypeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_type_id, :integer, :default => 0
  end
end
