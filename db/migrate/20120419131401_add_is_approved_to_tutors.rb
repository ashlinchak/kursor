class AddIsApprovedToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :is_approved, :boolean, :default => false
  end
end
