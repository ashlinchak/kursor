class CustomField < ActiveRecord::Base

  has_many :custom_field_bindings, :dependent => :destroy
  has_many :providers, :through => :custom_field_bindings

  default_scope order('position ASC, created_at DESC')

  def to_s
    name
  end

  def value_for_provider(provider)
    custom_field_bindings.where(:provider_id => provider.id).first.value
  end

end
