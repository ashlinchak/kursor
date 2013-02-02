class AddPostingsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :postings_count, :integer, :default => 0

    User.reset_column_information

    User.all.each do |user|
      user.postings_count = user.postings.count
      user.save
    end if column_exists?(:users, :postings_count)
  end
end
