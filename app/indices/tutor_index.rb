ThinkingSphinx::Index.define :tutor, :with => :active_record do
  indexes :name
  indexes :description
  set_property :field_weights => { :name => 10, :description => 6 }
  set_property :enable_star => 1
  set_property :min_infix_len => 3
  set_property :html_strip => 1
end