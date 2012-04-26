class AddMoreFieldsToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :methodology, :text
    add_column :tutors, :more_info, :text
  end
end
