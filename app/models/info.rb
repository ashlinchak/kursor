class Info < ActiveRecord::Base

  belongs_to :parent, :class_name => 'Info'

  validates :title, :body, :permalink, :presence => true
  validates :permalink, :uniqueness => true

  def to_param
    permalink
  end

  def to_s
    title
  end
end
