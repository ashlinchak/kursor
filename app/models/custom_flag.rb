class CustomFlag < ActiveRecord::Base
  has_many :custom_flag_bindings
  has_many :providers, :through => :custom_flag_bindings

  def to_s
    name
  end
end
