class TutorCustomField < ActiveRecord::Base
  has_many :tutor_custom_field_bindings
  has_many :tutors, :through => :tutor_custom_field_bindings

  default_scope order('position ASC, created_at DESC')

  def to_s
    name
  end
end
