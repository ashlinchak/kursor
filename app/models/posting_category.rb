class PostingCategory < ActiveRecord::Base

  belongs_to :parent, :class_name => 'PostingCategory'

  has_many :children, :class_name => 'PostingCategory', :foreign_key => 'parent_id', :dependent => :destroy

  has_many :posting_categorizings, :dependent => :destroy

  has_many :postings, :through => :posting_categorizings

  has_many :sub_postings, :through => :posting_categorizings, :source => :posting

  validates_presence_of :name, :description, :permalink
  validates :name, :permalink, :uniqueness => true

  validates_format_of :permalink, :with => /^[a-z\d\-]*$/, :message => "a-z, 0-9 \' - \' ONLY"

  scope :roots, where(:parent_id => nil)

  before_save :generate_permalink

  default_scope order('position ASC, created_at DESC')

  def self.post_cat
    find_by_permalink('posts')
  end

  def self.blog_cat
    find_by_permalink('blog')
  end

  def self.wiki_cat
    find_by_permalink('wiki')
  end

  def self.video_cat
    find_by_permalink('video')
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
