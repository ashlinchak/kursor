class AddProvidersCountToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :providers_count, :integer, :default => 0

    Category.reset_column_information

    Category.all.each do |category|
      category.providers_count = category.categorizings.count
      category.save
    end if column_exists?(:categories, :providers_count)
  end
end
