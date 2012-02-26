class PostingCategory < ActiveRecord::Base

  belongs_to :parent, :class_name => 'PostingCategory'
  has_many :children, :class_name => 'PostingCategory', :foreign_key => 'parent_id', :dependent => :destroy

  has_many :posting_categorizings, :dependent => :destroy
  has_many :postings, :through => :posting_categorizings

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
