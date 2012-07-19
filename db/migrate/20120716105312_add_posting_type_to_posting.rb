class AddPostingTypeToPosting < ActiveRecord::Migration
  def change
    add_column :postings, :posting_type_id, :integer, :default => 0
  end
end
