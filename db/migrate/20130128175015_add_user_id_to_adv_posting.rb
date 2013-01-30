class AddUserIdToAdvPosting < ActiveRecord::Migration
  def change
    add_column :adv_postings, :user_id, :integer
  end
end
