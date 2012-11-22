class AddPublishedAtToPosting < ActiveRecord::Migration
  def change
    add_column :postings, :published_at, :datetime
  end
end
