ThinkingSphinx::Index.define :tag, :with => :active_record do
  indexes :name
  set_property :enable_star => 1
  set_property :min_infix_len => 3
  set_property :html_strip => 1
end