ThinkingSphinx::Index.define :event, :with => :active_record do
  indexes :title
  indexes :description
  set_property :field_weights => { :title => 10, :description => 6 }
  set_property :enable_star => 1
  set_property :min_infix_len => 3
  set_property :html_strip => 1
end