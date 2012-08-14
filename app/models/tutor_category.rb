class TutorCategory < ActiveRecord::Base

  belongs_to :parent, :class_name => 'TutorCategory'
  has_many :children, :class_name => 'TutorCategory', :foreign_key => 'parent_id', :dependent => :destroy
  has_many :top_tutor_subcategories, :class_name => 'TutorCategory', :limit => 5, :order => 'tutors_count desc', :foreign_key => 'parent_id', :dependent => :destroy

  has_many :tutor_categorizings, :dependent => :destroy
  has_many :tutors
  has_many :sub_tutors, :through => :tutor_categorizings, :source => :tutor

  validates_presence_of :name, :description, :permalink
  validates :name, :permalink, :uniqueness => true

  validates_format_of :permalink, :with => /^[a-z\d\-]*$/, :message => "a-z, 0-9 \' - \' ONLY"

  scope :roots, where(:parent_id => nil)

  before_save :generate_permalink

  default_scope order('position ASC')

  mount_uploader :icon, TutorCategoryIconUploader

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
