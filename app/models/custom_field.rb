class CustomField < ActiveRecord::Base
  has_many :custom_field_bindings
  has_many :providers, :through => :custom_field_bindings

  default_scope order('position ASC, created_at DESC')

  def to_s
    name
  end
end
