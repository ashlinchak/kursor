class Tag < ActiveRecord::Base

  has_many :taggings, :dependent => :destroy

  validates_presence_of   :name
  validates_uniqueness_of :name

  def to_s
    name
  end

  def to_param
    name
  end

  def text
    name
  end

  define_index do
    indexes :name
    set_property :star => 1
    set_property :min_infix_len => 3
  end

end
