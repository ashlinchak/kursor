class Info < ActiveRecord::Base

  belongs_to :parent, :class_name => 'Info'

  def to_param
    permalink
  end

  def to_s
    title
  end
end
