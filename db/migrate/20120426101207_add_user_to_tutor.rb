class AddUserToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :user_id, :integer
  end
end
