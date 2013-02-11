class AddPostingsCounterToAdvCateory < ActiveRecord::Migration
  def change
    add_column :adv_categories, :postings_count, :integer, :default => 0

    Adv::Category.reset_column_information

    Adv::Category.all.each do |cat|
      cat.postings_count = cat.postings.count
      cat.save
    end if column_exists?(:adv_categories, :postings_count)
  end
end
