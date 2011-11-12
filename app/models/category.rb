class Category < ActiveRecord::Base
  #has_attached_file :cat_image, :styles => { :thumb => "100x100" }

  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'

  has_many :categorizings, :dependent => :destroy
  has_many :providers
  #has_many :categories, :through => :categorizings

  validates_presence_of :name, :description, :permalink
  validate :name, :uniqueness => true

  scope :roots, where(:parent_id => nil)

  def to_param
    permalink
  end

  def to_s
    name
  end

  def root?
    parent_id.nil?
  end
end
