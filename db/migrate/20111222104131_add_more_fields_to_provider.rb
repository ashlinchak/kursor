class AddMoreFieldsToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :more_info, :text
    add_column :providers, :documents_info, :text
  end
end
