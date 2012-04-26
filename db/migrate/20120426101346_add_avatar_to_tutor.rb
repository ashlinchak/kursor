class AddAvatarToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :avatar, :string
  end
end
