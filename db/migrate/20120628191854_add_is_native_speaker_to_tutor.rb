class AddIsNativeSpeakerToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :is_native_speaker, :boolean
  end
end
