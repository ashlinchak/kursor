class AddUkrainianFieldsToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :more_info_uk, :text
    add_column :providers, :documents_info_uk, :text
  end
end
