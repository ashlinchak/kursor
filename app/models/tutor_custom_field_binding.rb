class TutorCustomFieldBinding < ActiveRecord::Base
  belongs_to :tutor_custom_field
  belongs_to :tutor

  def name
    tutor_custom_field.name
  end

  def position
    tutor_custom_field.position
  end

end
