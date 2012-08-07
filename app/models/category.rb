class Category < ActiveRecord::Base

  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id', :dependent => :destroy
  has_many :top_subcategories, :class_name => 'Category', :limit => 5, :order => 'providers_count desc', :foreign_key => 'parent_id', :dependent => :destroy

  has_many :categorizings, :dependent => :destroy
  has_many :providers
  has_many :sub_providers, :through => :categorizings, :source => :provider

  validates_presence_of :name, :description, :permalink
  validates :name, :permalink, :uniqueness => true

  validates_format_of :permalink, :with => /^[a-z\d\-]*$/, :message => "a-z, 0-9 \' - \' ONLY"

  scope :roots, where(:parent_id => nil)

  before_save :generate_permalink

  default_scope order('position ASC')

  mount_uploader :icon, CategoryIconUploader

  def root_category_providers_count
    @count = 0
    for child in self.children do
      @count += child.providers_count
    end
    @count
  end

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
