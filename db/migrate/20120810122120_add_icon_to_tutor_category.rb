class AddIconToTutorCategory < ActiveRecord::Migration
  def change
    add_column :tutor_categories, :icon, :string
  end
end
