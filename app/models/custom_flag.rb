class CustomFlag < ActiveRecord::Base
  has_many :custom_flag_bindings
  has_many :providers, :through => :custom_flag_bindings

  default_scope order('position ASC, created_at DESC')

  def to_s
    name
  end
end
