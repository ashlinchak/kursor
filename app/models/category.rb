class Category < ActiveRecord::Base

  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'

  has_many :categorizings, :dependent => :destroy
  has_many :providers
  #has_many :categories, :through => :categorizings

  validates_presence_of :name, :description, :permalink
  validates :name, :permalink, :uniqueness => true

  scope :roots, where(:parent_id => nil)

  before_save :generate_permalink

  def to_param
    permalink
  end

  def to_s
    name
  end

  def root?
    parent_id.nil?
  end

  def generate_permalink
      # make simple util to parametrize/slugify permalink
      self.permalink = Russian.translit(name).parameterize if permalink.blank?
    #end
  end

end
