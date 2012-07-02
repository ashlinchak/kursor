class Info < ActiveRecord::Base

  belongs_to :parent, :class_name => 'Info'

  has_many :children, :class_name => 'Info', :foreign_key => 'parent_id', :dependent => :destroy

  validates :title, :body, :permalink, :presence => true
  validates :permalink, :uniqueness => true

  validates_format_of :permalink, :with => /^[a-z\d\-]*$/, :message => "a-z, 0-9 \' - \' ONLY"

  scope :roots, where(:parent_id => nil)

  def has_children?
    self.children.size > 0
  end

  def root?
    parent_id.nil?
  end

  def to_param
    permalink
  end

  def to_s
    title
  end
end
