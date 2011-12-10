class CustomField < ActiveRecord::Base
  has_many :custom_field_bindings
  has_many :providers, :through => :custom_field_bindings

  def to_s
    name
  end
end
