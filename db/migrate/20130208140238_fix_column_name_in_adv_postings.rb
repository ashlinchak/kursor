class FixColumnNameInAdvPostings < ActiveRecord::Migration
  def change
  	rename_column :adv_postings, :adv_category_id, :category_id
  end
end
