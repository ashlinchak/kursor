class AddUserToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :user_id, :integer
  end
end
