class AddIsApprovedToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :is_approved, :boolean, :default => false
  end
end
