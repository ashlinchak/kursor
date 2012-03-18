class AddIsApprovedToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :is_approved, :boolean, :default => false
  end
end
